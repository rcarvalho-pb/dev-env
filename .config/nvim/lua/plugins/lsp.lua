return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        vim.diagnostic.config({
            virtual_text = { spacing = 2, prefix = "●" },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = { border = "rounded" },
        })

        vim.lsp.config("gopls", {
            settings = {
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                },
            },
        })

        -- Toggle de inlay hints. Separada em função nomeada (mesmo estilo do
        -- toggle_lsp mais abaixo) para poder ser chamada tanto pelo keymap
        -- quanto, futuramente, por outro lugar sem duplicar lógica.
        --
        -- local function toggle_inlay_hints(bufnr)
            --   local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
            --   vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
            --   if enabled then print("InlayHints is Enabled") else print("InlayHints is Disabled")
            -- end

            local function toggle_inlay_hints(bufnr)
                local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                local new_state = not is_enabled

                vim.lsp.inlay_hint.enable(new_state, { bufnr = bufnr })

                if new_state then
                    vim.notify("Inlay Hints ativados", vim.log.levels.INFO, { title = "LSP" })
                else
                    vim.notify("Inlay Hints desativados", vim.log.levels.INFO, { title = "LSP" })
                end
            end
            -- Lista de keymaps que só devem existir enquanto houver um cliente LSP
            -- ativo no buffer. É a mesma lista usada para registrar (LspAttach) e
            -- para remover (LspDetach) os atalhos.
            local function lsp_keymaps(bufnr)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                map("n", "gd", vim.lsp.buf.definition, "LSP: ir para definição")
                map("n", "gD", vim.lsp.buf.declaration, "LSP: ir para declaração")
                map("n", "gi", vim.lsp.buf.implementation, "LSP: ir para implementação")
                map("n", "gr", vim.lsp.buf.references, "LSP: referências")
                map("n", "gy", vim.lsp.buf.type_definition, "LSP: ir para definição do tipo")
                map("n", "K", vim.lsp.buf.hover, "LSP: hover / documentação")
                map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: renomear símbolo")
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
                map("n", "<leader>ds", vim.diagnostic.open_float, "LSP: mostrar diagnóstico")
                map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "LSP: diagnóstico anterior")
                map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "LSP: próximo diagnóstico")
                map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "LSP: formatar buffer")
                map("n", "<leader>ll", vim.lsp.codelens.run, "LSP: executar code lens")
                map("n", "<leader>lh", function() toggle_inlay_hints(bufnr) end, "LSP: toggle inlay hints")
            end

            local keymap_lhs = { "gd", "gD", "gi", "gr", "gy", "K", "<leader>rn", "<leader>ca", "<leader>ds", "[d", "]d", "<leader>lf", "<leader>ll", "<leader>lh" }

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = function(event)
                    lsp_keymaps(event.buf)

                    -- habilita inlay hints por padrão para qualquer servidor que suporte
                    -- (jdtls, gopls, rust_analyzer, ts_ls, lua_ls, etc.)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client:supports_method("textDocument/inlayHint") then
                        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
                    end
                end,
            })

            -- Ao desanexar o último cliente LSP do buffer, remove os atalhos: sem
            -- LSP ativo, os atalhos não devem estar disponíveis.
            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
                callback = function(event)
                    if #vim.lsp.get_clients({ bufnr = event.buf }) <= 1 then
                        for _, lhs in ipairs(keymap_lhs) do
                            pcall(vim.keymap.del, "n", lhs, { buffer = event.buf })
                            pcall(vim.keymap.del, "v", lhs, { buffer = event.buf })
                        end
                    end
                end,
            })

            -- Toggle do LSP no buffer atual. Fica FORA da lista acima de propósito:
            -- esse atalho precisa continuar disponível mesmo com o LSP desligado,
            -- senão não teria como religar.
            local function toggle_lsp()
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })
                if #clients > 0 then
                    for _, client in ipairs(clients) do
                        vim.lsp.stop_client(client.id)
                    end
                    vim.notify("LSP desativado neste buffer", vim.log.levels.INFO, { title = "LSP" })
                else
                    -- reabre o buffer para disparar o FileType/autostart do lspconfig de novo
                    vim.cmd("edit")
                    vim.notify("LSP reativado neste buffer", vim.log.levels.INFO, { title = "LSP" })
                end
            end

            vim.keymap.set("n", "<leader>lt", toggle_lsp, { desc = "LSP: toggle (ligar/desligar no buffer)" })
        end,
    }

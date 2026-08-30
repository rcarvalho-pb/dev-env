-- Java é o foco principal, então usamos o nvim-jdtls (em vez de deixar o
-- jdtls ser subido genericamente pelo lspconfig/mason-lspconfig). Isso dá
-- workspace isolado por projeto, suporte a debug (com nvim-dap, se
-- adicionado depois) e melhor integração com Maven/Gradle.
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    local jdtls = require("jdtls")
    local mason_registry = require("mason-registry")
    local jdtls_pkg = mason_registry.get_package("jdtls")
    local jdtls_path = jdtls_pkg:get_install_path()

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

    local os_config = "config_linux"
    if vim.fn.has("mac") == 1 then
      os_config = "config_mac"
    elseif vim.fn.has("win32") == 1 then
      os_config = "config_win"
    end

    local function start_jdtls()
      local config = {
        cmd = {
          "java",
          "-jar",
          vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
          "-configuration",
          jdtls_path .. "/" .. os_config,
          "-data",
          workspace_dir,
        },
        root_dir = require("jdtls.setup").find_root({ "pom.xml", "build.gradle", "build.gradle.kts", ".git" }),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            completion = { favoriteStaticMembers = {} },
          },
        },
        init_options = {
          bundles = {},
        },
        on_attach = function(_, bufnr)
          -- reaproveita os keymaps compartilhados de LSP (gd, K, <leader>rn, etc.)
          -- que já são registrados via LspAttach em lua/plugins/lsp.lua;
          -- aqui só adicionamos os que são específicos do jdtls
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          map("n", "<leader>jo", jdtls.organize_imports, "Java: organizar imports")
          map("n", "<leader>jv", jdtls.extract_variable, "Java: extrair variável")
          map("v", "<leader>jm", [[<esc><cmd>lua require('jdtls').extract_method(true)<cr>]], "Java: extrair método")
        end,
      }
      jdtls.start_or_attach(config)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      group = vim.api.nvim_create_augroup("user-jdtls", { clear = true }),
      callback = start_jdtls,
    })
  end,
}

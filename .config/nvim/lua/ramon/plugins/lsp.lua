vim.diagnostic.config({
	virtual_text = true, -- Exibe a mensagem de aviso na própria linha
	signs = true,        -- Mostra ícones na coluna lateral (sign column)
	underline = true,    -- Sublinha o código com problemas
	update_in_insert = false, -- Não atualiza os avisos enquanto você digita
	severity_sort = true,
})

-- 1. Gerenciamento de pacotes
vim.pack.add({
	"Saghen/blink.cmp",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
})

-- 2. Configuração do Autocompletar (blink.cmp)
local blink = require("blink.cmp")
blink.setup({
	keymap = { preset = "default" },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
})

-- 3. Autocmd LspAttach: Atalhos e Inlay Hints
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local bufnr = event.buf

		-- Helper local para atalhos
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = "LSP: " .. desc })
		end

		-------------------------------------------------------------------
		-- ATALHOS DE NAVEGAÇÃO E DIAGNÓSTICOS (AVISOS/ERROS)
		-------------------------------------------------------------------
		map("n", "gl", vim.diagnostic.open_float, "Mostrar Aviso da Linha")
		map("n", "[d", vim.diagnostic.goto_prev, "Ir para Aviso Anterior")
		map("n", "]d", vim.diagnostic.goto_next, "Ir para Próximo Aviso")
		map("n", "<leader>q", vim.diagnostic.setloclist, "Listar Avisos na Quickfix")

		-------------------------------------------------------------------
		-- ATALHOS PADRÃO DO LSP
		-------------------------------------------------------------------
		map("n", "gd", vim.lsp.buf.definition, "Ir para Definição")
		map("n", "gD", vim.lsp.buf.declaration, "Ir para Declaração")
		map("n", "gr", vim.lsp.buf.references, "Listar Referências")
		map("n", "gi", vim.lsp.buf.implementation, "Ir para Implementação")
		map("n", "K", vim.lsp.buf.hover, "Documentação Hover")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Renomear Símbolo")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Ações de Código")

		-------------------------------------------------------------------
		-- INLAY HINTS (API Neovim 0.11/0.12+)
		-------------------------------------------------------------------
		if client and client:supports_method("textDocument/inlayHint", bufnr) then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

			map("n", "<leader>th", function()
				local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
				vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
				print("Inlay Hints: " .. (not is_enabled and "Ativados" or "Desativados"))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

-- 4. Mason & LSPConfig
require("mason").setup()

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = blink.get_lsp_capabilities()

mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"pyright",
		"gopls",
		"zls",
		"clangd",
		"eslint",
		"emmet_ls",
		"bashls",
		"stylua",
		"templ",
	},
	automatic_installation = true,

	handlers = {
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end,

		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})
		end,
	},
})

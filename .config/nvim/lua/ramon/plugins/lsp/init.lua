require("mason").setup({})

-- Configuração dos Diagnostics
local diagnostic_signs = { Error = " ", Warn = " ", Hint = "", Info = "" }
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

-- Bordas globais para janelas flutuantes do LSP (hover, etc)
local orig = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig(contents, syntax, opts, ...)
end

-- Mapeamento de Keymaps quando o LSP se conecta ao buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end
		local bufnr = ev.buf
		local opts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set("n", "gd", function()
			require("fzf-lua").lsp_definitions({ jump1 = true })
		end, opts)
		vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gS", function()
			vim.cmd("vsplit")
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>D", function()
			vim.diagnostic.open_float({ scope = "line" })
		end, opts)
		vim.keymap.set("n", "<leader>d", function()
			vim.diagnostic.open_float({ scope = "cursor" })
		end, opts)
		vim.keymap.set("n", "<leader>nd", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts)
		vim.keymap.set("n", "<leader>pd", function()
			vim.diagnostic.jump({ count = -1 })
		end, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>fd", function()
			require("fzf-lua").lsp_definitions({ jump1 = true })
		end, opts)
		vim.keymap.set("n", "<leader>fr", function()
			require("fzf-lua").lsp_references()
		end, opts)
		vim.keymap.set("n", "<leader>ft", function()
			require("fzf-lua").lsp_typedefs()
		end, opts)
		vim.keymap.set("n", "<leader>fs", function()
			require("fzf-lua").lsp_document_symbols()
		end, opts)
		vim.keymap.set("n", "<leader>fw", function()
			require("fzf-lua").lsp_workspace_symbols()
		end, opts)
		vim.keymap.set("n", "<leader>fi", function()
			require("fzf-lua").lsp_implementations()
		end, opts)

		if client:supports_method("textDocument/inlayHint", bufnr) then
			vim.keymap.set("n", "<leader>ih", function()
				-- O primeiro argumento indica se deve ativar (true/false).
				-- Passando a negação do estado atual, criamos o efeito de Toggle.
				local current_state = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
				vim.lsp.inlay_hint.enable(not current_state, { bufnr = bufnr })

				-- Um print opcional para você saber se ligou ou desligou
				if not current_state then
					print("Inlay Hints: Ativado")
				else
					print("Inlay Hints: Desativado")
				end
			end, { noremap = true, silent = true, buffer = bufnr, desc = "Toggle Inlay Hints" })
		end

		if client:supports_method("textDocument/codeAction", bufnr) then
			vim.keymap.set("n", "<leader>oi", function()
				vim.lsp.buf.code_action({
					context = { only = { "source.organizeImports" }, diagnostics = {} },
					apply = true,
					bufnr = bufnr,
				})
				vim.defer_fn(function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end, 50)
			end, opts)
		end
	end,
})

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Carrega Blink e EFM configs primeiro
require("ramon.plugins.lsp.blink")
require("ramon.plugins.lsp.efm")

-- ============================================================================
-- AUTOMAÇÃO E INSTALAÇÃO AUTOMÁTICA (Neovim 0.12+)
-- ============================================================================

-- 1. Sua lista de LSPs desejados
local servers = {
	lua_ls = {
		settings = { Lua = { diagnostics = { globals = { "vim" } }, telemetry = { enable = false } } },
	},
	pyright = {},
	bashls = {},
	ts_ls = {},
	gopls = {},
	clangd = {},
	efm = {},
	zls = {},
}

-- 2. Lista de ferramentas externas que o EFM vai usar (Linters e Formatters)
-- O Mason vai garantir que o StyLua, Black, etc., estejam instalados no sistema
local efm_tools = {
	"stylua",
	-- "luacheck",
	"black",
	"flake8",
	"prettierd",
	"eslint_d",
	"fixjson",
	"shellcheck",
	"shfmt",
	"cpplint",
	"clang-format",
	"revive",
	"gofumpt",
}

-- 3. Configura o mason-lspconfig para baixar os LSPs automaticamente
local servers_to_install = {}
for server_name, _ in pairs(servers) do
	table.insert(servers_to_install, server_name)
end

require("mason-lspconfig").setup({
	ensure_installed = servers_to_install, -- Garante a instalação de todos da lista
	automatic_installation = true, -- Se você abrir um arquivo novo e o LSP não estiver aqui, ele baixa sozinho!
})

-- 4. Configura o mason-tool-installer para baixar as ferramentas do EFM automaticamente
require("mason-tool-installer").setup({
	ensure_installed = efm_tools,
	auto_update = false,
	run_on_start = true,
})

-- 5. Loop para aplicar o lsp.config em cada um
local servers_to_enable = {}
for server_name, server_config in pairs(servers) do
	if server_name ~= "efm" then
		vim.lsp.config(server_name, server_config)
	end
	table.insert(servers_to_enable, server_name)
end

-- 6. Ativa todos os servidores de uma vez
vim.lsp.enable(servers_to_enable)

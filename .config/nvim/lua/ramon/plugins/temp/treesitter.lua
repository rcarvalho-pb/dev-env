-- Configuração do Treesitter
local treesitter = require("nvim-treesitter")
treesitter.setup({})
local ensure_installed = {
	"vim",
	"vimdoc",
	"rust",
	"c",
	"cpp",
	"go",
	"html",
	"css",
	"javascript",
	"json",
	"lua",
	"markdown",
	"python",
	"typescript",
	"vue",
	"svelte",
	"bash",
	"zig",
}

local config = require("nvim-treesitter.config")
config.setup({
	ensure_installed = {
		"vim",
		"vimdoc",
		"rust",
		"c",
		"cpp",
		"go",
		"html",
		"css",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"typescript",
		"vue",
		"svelte",
		"bash",
		"zig",
	},

	-- 2. A MAGIA: Instala automaticamente o parser correto ao abrir um arquivo novo!
	auto_install = true,

	-- 3. Ativa o Highlight baseado no Treesitter
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
-- local already_installed = config.get_installed()
-- local parsers_to_install = {}
--
-- for _, parser in ipairs(ensure_installed) do
-- 	if not vim.tbl_contains(already_installed, parser) then
-- 		table.insert(parsers_to_install, parser)
-- 	end
-- end

-- if #parsers_to_install > 0 then
-- 	treesitter.install(parsers_to_install)
-- end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true }),
	callback = function(args)
		if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
			vim.treesitter.start(args.buf)
		end
	end,
})

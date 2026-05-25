require("fzf-lua").setup({})
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

vim.keymap.set("n", "<leader>fn", function()
	-- vim.fn.stdpath("config") descobre automaticamente onde seu Neovim está instalado
	-- (funciona no Linux, Mac e Windows sem você precisar mudar o caminho manualmente)
	local config_dir = vim.fn.stdpath("config")

	require("fzf-lua").files({
		cwd = config_dir,
		prompt = "Nvim Config> ", -- Altera o texto do buscador para ficar temático
	})
end, { desc = "Find Neovim files" })

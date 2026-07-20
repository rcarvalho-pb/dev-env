local wk = require("which-key")

-- Configuração geral do comportamento e visual
wk.setup({
	preset = "modern", -- Layout moderno e limpo
	delay = function(ctx)
		return ctx.plugin and 0 or 400 -- Abre em 400ms se você hesitar no atalho
	end,
	win = {
		border = "rounded", -- Combina com as bordas arredondadas do seu LSP e Terminal
		no_overlap = true,
	},
})

-- Registrar os nomes dos grupos do seu <leader> para organizar o menu
wk.add({
	{ "<leader>b", group = "Buffers" },
	{ "<leader>f", group = "Find (FZF)" },
	{ "<leader>g", group = "Go to / LSP" },
	{ "<leader>h", group = "Git Hunks / Harpoon" }, -- <-- Atualizado aqui!
	{ "<leader>n", group = "Notes (Obsidian)" },
	{ "<leader>s", group = "Split Windows" },
	{ "<leader>t", group = "Toggle / Terminal" },
})

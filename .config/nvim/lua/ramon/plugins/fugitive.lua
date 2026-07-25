-- 1. Baixa o vim-fugitive (e o rhubarb para suporte ao GitHub)
vim.pack.add({
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/tpope/vim-rhubarb", -- Opcional: permite usar :GBrowse para abrir o arquivo no GitHub
})

-------------------------------------------------------------------
-- ATALHOS DO VIM-FUGITIVE
-------------------------------------------------------------------

-- 1. Painel Principal do Git (:Git / :G)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus (Fugitive)" })

-- 2. Diff Split (compara o arquivo atual com a versão do index)
vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { silent = true, desc = "[G]it [D]iff Split" })

-- 3. Git Blame (mostra quem alterou cada linha)
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { silent = true, desc = "[G]it [B]lame" })

-- 4. Comandos rápidos de Push e Pull
vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { silent = true, desc = "[G]it [P]ush" })
vim.keymap.set("n", "<leader>gP", ":Git pull --rebase<CR>", { silent = true, desc = "[G]it [P]ull (rebase)" })

-- 5. Abrir a linha/arquivo atual diretamente no GitHub (requer vim-rhubarb)
vim.keymap.set({ "n", "v" }, "<leader>gh", ":GBrowse<CR>", { silent = true, desc = "Abrir no [G]it[H]ub" })
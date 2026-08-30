-- Keymaps gerais. Os keymaps de LSP ficam em lua/plugins/lsp.lua,
-- registrados apenas quando um servidor LSP anexa no buffer (LspAttach).
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Limpar destaque de busca" })

map("i", "jj", "<Esc>", { desc = "Sair do modo de edição" })
map("i", "jk", "<Esc>", { desc = "Sair do modo de edição" })
map("i", "kk", "<Esc>", { desc = "Sair do modo de edição" })

-- navegação entre janelas
map("n", "<C-h>", "<C-w>h", { desc = "Foco na janela à esquerda" })
map("n", "<C-l>", "<C-w>l", { desc = "Foco na janela à direita" })
map("n", "<C-j>", "<C-w>j", { desc = "Foco na janela abaixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Foco na janela acima" })

-- atalhos básicos
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Salvar arquivo" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Fechar janela" })

-- mover linhas selecionadas no visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Mover seleção para baixo" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Mover seleção para cima" })

-- manter cursor centralizado ao navegar
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

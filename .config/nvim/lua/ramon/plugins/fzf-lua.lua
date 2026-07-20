-- 1. Baixa o fzf-lua e a biblioteca de ícones via vim.pack
vim.pack.add({
  "nvim-tree/nvim-web-devicons",
  "ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")

-- 2. Configuração Básica do fzf-lua
fzf.setup({
  -- Layout da janela flutuante
  winopts = {
    height = 0.85,
    width = 0.80,
    row = 0.35,
    col = 0.50,
    border = "rounded",
  },
  -- Usa o motor embutido (não precisa de fzf instalado no sistema)
  files = {
    prompt = "Files> ",
    multiprocess = true,
  },
})

-------------------------------------------------------------------
-- ATALHOS DO FZF-LUA
-------------------------------------------------------------------

-- 1. ATALHO SOLICITADO: Abrir arquivos de configuração do Neovim (<leader>fc ou <leader>fn)
vim.keymap.set("n", "<leader>fc", function()
  fzf.files({
    prompt = "Nvim Config> ",
    cwd = vim.fn.stdpath("config"), -- Aponta diretamente para ~/.config/nvim (ou AppData/nvim no Windows)
  })
end, { desc = "[F]ind [C]onfig (Neovim)" })

-- 2. Buscar arquivos no projeto atual
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "[F]ind [F]iles (Projeto)" })

-- 3. Buscar texto dentro dos arquivos do projeto (Live Grep)
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "[F]ind por [G]rep" })

-- 4. Buscar buffers abertos
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "[F]ind [B]uffers" })

-- 5. Buscar na ajuda do Neovim
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "[F]ind [H]elp" })

-- 6. Integrado ao LSP: Buscar Símbolos no projeto
vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "[F]ind [S]ymbols (LSP)" })

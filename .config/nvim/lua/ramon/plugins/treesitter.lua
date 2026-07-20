-- 1. Garante a instalação/carregamento do plugin via vim.pack
vim.pack.add({
  "nvim-treesitter/nvim-treesitter",
})

-- Force o carregamento do pacote se necessário
vim.cmd("packadd! nvim-treesitter")

-- 2. Define o Zig como compilador antes do setup
require("nvim-treesitter.install").compilers = { "zig" }

-- 3. Nova API do nvim-treesitter (versão moderna/main branch)
local ts = require("nvim-treesitter")

ts.setup({
  -- Idiomas para manter instalados
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "query",
    "markdown",
    "markdown_inline",
    "python",
    "typescript",
    "javascript",
    "bash",
    "zig",
  },
  -- Instalação automática ao abrir novas linguagens
  auto_install = true,
})

-- 4. Habilita o Treesitter Nativo do Neovim 0.12+
-- No Neovim moderno, o Highlight e Indentação são ativados via Autocmd nativa:
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterNative", { clear = true }),
  callback = function()
    -- Ativa o highlight sintático baseado em Treesitter no buffer
    pcall(vim.treesitter.start)
  end,
})

-- 5. Dobra de Código (Folding) com Treesitter Nativo
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:treesitter#foldexpr()"
vim.opt.foldenable = false -- Começa com o código aberto
vim.opt.foldlevel = 99

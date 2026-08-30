vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- desabilita alguns plugins nativos que não vamos usar
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1 -- o oil.nvim substitui o netrw como explorador de arquivos

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 8
opt.termguicolors = true

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.wrap = false

opt.confirm = true
opt.completeopt = { "menu", "menuone", "noselect" }

require("vim._core.ui2").enable({})
-- Garante que o leader está configurado antes de carregar os keymaps/plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Carrega as configurações fundamentais
require("ramon.core")
-- Carrega os plugins e suas respectivas configurações
require("ramon.plugins")

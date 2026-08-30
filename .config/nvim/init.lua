-- Entry point da configuração.
-- Ordem importa: options define o <leader> ANTES de carregarmos o lazy.nvim,
-- pois os keymaps dos plugins usam <leader> na hora de serem registrados.
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

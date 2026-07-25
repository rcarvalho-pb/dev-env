-- 1. Baixa o plugin via vim.pack
vim.pack.add({
  "folke/flash.nvim",
})

local flash = require("flash")

-- 2. Configuração Básica (Opcional - os padrões já são excelentes)
flash.setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  search = {
    multi_window = true, -- Permite pular entre janelas/splits abertos
  },
})

-------------------------------------------------------------------
-- ATALHOS DO FLASH.NVIM
-------------------------------------------------------------------

-- Pular para qualquer palavra/caractere visível na tela
vim.keymap.set({ "n", "x", "o" }, "s", function()
  flash.jump()
end, { desc = "Flash Jump" })

-- Selecionar nós do Treesitter (Funções, blocos, etc.)
vim.keymap.set({ "n", "x", "o" }, "S", function()
  flash.treesitter()
end, { desc = "Flash Treesitter" })

-- Usar o Flash no modo de Operador (ex: 'd' + 'r' para deletar até um ponto remoto)
vim.keymap.set("o", "r", function()
  flash.remote()
end, { desc = "Remote Flash" })
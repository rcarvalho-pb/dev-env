return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    return {
      { "<leader>a", function() harpoon:list():add() end, desc = "Harpoon: adicionar arquivo" },
      { "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: menu rápido" },
      { "<leader>1", function() harpoon:list():select(1) end, desc = "Harpoon: arquivo 1" },
      { "<leader>2", function() harpoon:list():select(2) end, desc = "Harpoon: arquivo 2" },
      { "<leader>3", function() harpoon:list():select(3) end, desc = "Harpoon: arquivo 3" },
      { "<leader>4", function() harpoon:list():select(4) end, desc = "Harpoon: arquivo 4" },
      { "<C-S-P>", function() harpoon:list():prev() end, desc = "Harpoon: arquivo anterior" },
      { "<C-S-N>", function() harpoon:list():next() end, desc = "Harpoon: próximo arquivo" },
    }
  end,
  config = function()
    require("harpoon"):setup()
  end,
}

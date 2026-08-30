return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Próximo TODO/FIXME" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "TODO/FIXME anterior" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Buscar TODOs" },
  },
  opts = {},
}

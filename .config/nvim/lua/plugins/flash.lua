return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash: saltar" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash: saltar (treesitter)" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Flash: remote (operator)" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Flash: treesitter search" },
  },
}

-- Por que Telescope e não fzf-lua: o fzf-lua depende do binário externo
-- `fzf` (roda ele num terminal embutido). O Telescope, com o sorter padrão
-- (implementado em Lua puro, sem precisar compilar nada nem instalar o app
-- fzf no sistema), já dá uma experiência de busca fuzzy equivalente,
-- 100% dentro do Neovim.
return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Buscar arquivos" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Buscar texto (grep)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buscar buffers abertos" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Buscar ajuda" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Arquivos recentes" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Buscar diagnósticos" },
    {
      "<leader>fn",
      function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end,
      desc = "Buscar arquivos da config do Neovim",
    },
    {
      "<leader>fN",
      function() require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config") }) end,
      desc = "Grep na config do Neovim",
    },
  },
  opts = {
    defaults = {
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
    },
  },
}

return {
  -- biblioteca de componentes de UI usada por outros plugins (ex.: menus,
  -- popups); não precisa de configuração própria
  { "MunifTanjim/nui.nvim", lazy = true },

  -- embeleza vim.ui.select() e vim.ui.input() (ex.: rename do LSP,
  -- code actions, confirmações) usando os componentes do nui.nvim
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { border = "rounded" },
      select = { backend = { "telescope", "nui", "builtin" } },
    },
  },
}

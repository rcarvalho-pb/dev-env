return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- precisa carregar cedo para poder substituir o netrw
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Abrir diretório pai (Oil)" },
    { "<leader>oe", "<cmd>Oil --float<cr>", desc = "Explorador de arquivos flutuante" },
  },
  opts = {
    default_file_explorer = true,
    view_options = { show_hidden = true },
    delete_to_trash = true,
  },
}

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "<leader>f", group = "Buscar (telescope)" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git hunks" },
      { "<leader>j", group = "Java" },
      { "<leader>o", group = "Oil / arquivos" },
      { "<leader>l", group = "LSP" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Diagnóstico" },
    },
  },
}

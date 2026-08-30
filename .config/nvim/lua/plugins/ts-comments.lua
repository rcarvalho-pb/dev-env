-- Usa o treesitter para escolher o comentário correto em arquivos com
-- linguagens embutidas (ex.: <script> num .html, JS dentro de um .templ etc.)
return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  opts = {},
}

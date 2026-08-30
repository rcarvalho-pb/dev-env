-- O nvim-treesitter compila os parsers em runtime usando o compilador C
-- disponível no sistema (cc/gcc/clang) e :TSUpdate. Não é necessário ter o
-- binário `tree-sitter` (CLI) instalado — ele só seria necessário para gerar
-- queries/parsers customizados, o que não é o nosso caso.
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "java",
      "go",
      "zig",
      "kotlin",
      "rust",
      "ruby",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "templ",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "bash",
      "regex",
      "sql",
      "dockerfile",
      "gitignore",
      "diff",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    local ts = require("nvim-treesitter")
    if ts.install then
      ts.install(opts.ensure_installed)
    end

    -- Usa o parser do bash para arquivos zsh
    vim.treesitter.language.register("bash", "zsh")
  end,
}

return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "gopls", -- go
        "zls", -- zig
        "kotlin_language_server", -- kotlin
        "rust_analyzer", -- rust
        -- "ruby_lsp", -- ruby
        "ts_ls", -- javascript / typescript
        "html",
        "cssls",
        "templ",
        "lua_ls",
        "efm", -- backend dos linters, ver lua/plugins/efm.lua
      },
      -- jdtls fica de fora do auto-enable do lspconfig: quem sobe/anexa o
      -- servidor de Java é o plugin nvim-jdtls (lua/plugins/lsp-java.lua),
      -- que precisa de configuração própria (workspace por projeto, etc.)
      automatic_enable = { exclude = { "jdtls" } },
    },
  },
  -- garante a instalação de ferramentas que não são "servidores LSP" para o
  -- mason-lspconfig (jdtls é LSP mas gerenciado à parte; os demais são
  -- linters usados pelo efm-langserver)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "jdtls",
        "eslint_d",
        "golangci-lint",
        -- "rubocop",
      },
    },
  },
}

-- efm-langserver funciona como uma "ponte" LSP para ferramentas de linter que
-- não falam o protocolo LSP nativamente. Ele mesmo é instalado pelo Mason
-- (ver ensure_installed em lua/plugins/mason.lua); aqui só configuramos quais
-- linters rodar para cada linguagem.
return {
  "neovim/nvim-lspconfig",
  optional = true,
  init = function()
    local eslint_d = {
      lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
      lintStdin = true,
      lintFormats = { "%f(%l,%c): %trror %m", "%f(%l,%c): %tarning %m" },
      lintIgnoreExitCode = true,
    }
    local golangci_lint = {
      lintCommand = "golangci-lint run --out-format=line-number ./...",
      lintStdin = false,
      lintFormats = { "%f:%l:%c: %m" },
      lintIgnoreExitCode = true,
    }
    -- local rubocop = {
    --   lintCommand = "rubocop --stdin ${INPUT} --format emacs --force-default-config",
    --   lintStdin = true,
    --   lintFormats = { "%f:%l:%c: %t: %m" },
    --   lintIgnoreExitCode = true,
    -- }

    vim.lsp.config("efm", {
      cmd = { "efm-langserver" },
      filetypes = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "go",
        -- "ruby",
      },
      init_options = { documentFormatting = false, documentRangeFormatting = false },
      settings = {
        rootMarkers = { ".git/" },
        languages = {
          javascript = { eslint_d },
          typescript = { eslint_d },
          javascriptreact = { eslint_d },
          typescriptreact = { eslint_d },
          go = { golangci_lint },
          -- ruby = { rubocop },
        },
      },
    })

    vim.lsp.enable("efm")
  end,
}

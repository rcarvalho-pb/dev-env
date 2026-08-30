return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
        preset = "none",

          -- Enter para confirmar a seleção
          ["<CR>"] = { "accept", "fallback" },

          -- Setas para navegar na lista
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },

          -- Teclas úteis mantidas para abrir/fechar menu e navegar em snippets/docs
          ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
          ["<C-e>"] = { "hide" },
          ["<Tab>"] = { "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "snippet_backward", "fallback" },
          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = {
      -- menu do autocomplete: mostra ícone + label + detalhe (assinatura/tipo)
      -- quando vem do LSP, não apenas o nome que será inserido
      menu = {
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
          },
        },
      },
      -- janela de documentação (docstring do LSP) some/aparece automaticamente
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      list = { selection = { preselect = true, auto_insert = false } },
    },

    -- fontes de completion para texto normal (insert mode)
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    -- autocomplete também para a linha de comando (:) do próprio Neovim
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      completion = {
        menu = { auto_show = true },
      },
    },

    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}

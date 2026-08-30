-- Usamos apenas os módulos de edição do mini.nvim (autoclose de parênteses/
-- aspas, surround e textobjects). O autocomplete da linha de comando (:) NÃO
-- vem daqui — isso é responsabilidade do blink.cmp (lua/plugins/completion.lua).
return {
  {
    "echasnovski/mini.pairs",
    version = false,
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    version = false,
    keys = { "sa", "sd", "sr", "sf", "sF", "sh", "sn", "sl" },
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
}

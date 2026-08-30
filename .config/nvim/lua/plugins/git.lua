return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Git: próximo hunk")
        map("n", "[h", gs.prev_hunk, "Git: hunk anterior")
        map("n", "<leader>hp", gs.preview_hunk, "Git: preview hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Git: stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Git: reset hunk")
        map("n", "<leader>hb", gs.blame_line, "Git: blame da linha")
        map("n", "<leader>hd", gs.diffthis, "Git: diff do arquivo")
      end,
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gclog", "Gread", "Gwrite" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status (fugitive)" },
      { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split (fugitive)" },
    },
  },
}

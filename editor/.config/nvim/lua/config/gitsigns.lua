local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▋" },
    change = { hl = "GitSignsChange", text = "▋" },
    delete = { hl = "GitSignsDelete", text = "▁" },
    topdelete = { hl = "GitSignsDelete", text = "▔" },
    changedelete = { hl = "GitSignsDelete", text = "~" },
  },
  numhl = false,
  linehl = false,
  watch_gitdir = {
    interval = 1000,
  },
  current_line_blame = true,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  diff_opts = {
    internal = true,
  },
  on_attach = function(bufnr)
    local normal_keymaps = {
      ["]c"] = { [[&diff ? "]c" : "<cmd>lua require('gitsigns').next_hunk()<CR>"]], "Jump to next hunk", expr = true },
      ["[c"] = {
        [[&diff ? "[c" : "<cmd>lua require('gitsigns').prev_hunk()<CR>"]],
        "Jump to previous hunk",
        expr = true,
      },

      ["<leader>h"] = {
        name = "Gitsigns",
        ["s"] = { gitsigns.stage_hunk, "Stage hunk" },
        ["u"] = { gitsigns.undo_stage_hunk, "Unstage hunk" },
        ["r"] = { gitsigns.reset_hunk, "Reset hunk" },
        ["R"] = { gitsigns.reset_buffer, "Reset buffer" },
        ["p"] = { gitsigns.preview_hunk, "Preview hunk" },
        ["b"] = { gitsigns.blame_line, "Blame line" },
      },
    }

    local wk = require("which-key")
    wk.register(normal_keymaps, { buffer = bufnr })

    -- Text objects
    wk.register({ ["ih"] = { gitsigns.select_hunk, "Select hunk" } }, { mode = "o", buffer = bufnr })
    wk.register({ ["ih"] = { gitsigns.select_hunk, "Select hunk" } }, { mode = "x", buffer = bufnr })
  end,
})

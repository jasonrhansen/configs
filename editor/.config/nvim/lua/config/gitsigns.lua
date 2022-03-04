require("gitsigns").setup({
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
        ["s"] = { "<cmd>lua require('gitsigns').stage_hunk()<CR>", "Stage hunk" },
        ["u"] = { "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", "Unstage hunk" },
        ["r"] = { "<cmd>lua require('gitsigns').reset_hunk()<CR>", "Reset hunk" },
        ["R"] = { "<cmd>lua require('gitsigns').reset_buffer()<CR>", "Reset buffer" },
        ["p"] = { "<cmd>lua require('gitsigns').preview_hunk()<CR>", "Preview hunk" },
        ["b"] = { "<cmd>lua require('gitsigns').blame_line()<CR>", "Blame line" },
      },
    }

    local wk = require("which-key")
    wk.register(normal_keymaps, { buffer = bufnr })

    -- Text objects
    wk.register(
      { ["ih"] = { ":<C-U>lua require('gitsigns').select_hunk()<CR>", "Select hunk" } },
      { mode = "o", buffer = bufnr }
    )
    wk.register(
      { ["ih"] = { ":<C-U>lua require('gitsigns').select_hunk()<CR>", "Select hunk" } },
      { mode = "x", buffer = bufnr }
    )
  end,
})

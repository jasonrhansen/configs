local M = {
  "lewis6991/gitsigns.nvim",
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  local gitsigns = require("gitsigns")

  gitsigns.setup({
    signs = {
      add = { text = "▋" },
      change = { text = "▋" },
      delete = { text = "▁" },
      topdelete = { text = "▔" },
      changedelete = { text = "~" },
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
      require("which-key").add({
        buffer = bufnr,
        {
          "]c",
          [[&diff ? "]c" : "<cmd>lua require('gitsigns').next_hunk()<CR>"]],
          desc = "Jump to next hunk",
          expr = true,
        },
        {
          "[c",
          [[&diff ? "[c" : "<cmd>lua require('gitsigns').prev_hunk()<CR>"]],
          desc = "Jump to previous hunk",
          expr = true,
        },
        { "<leader>s", group = "Gitsigns" },
        { "<leader>ss", gitsigns.stage_hunk, desc = "Stage hunk" },
        { "<leader>su", gitsigns.undo_stage_hunk, desc = "Unstage hunk" },
        { "<leader>sr", gitsigns.reset_hunk, desc = "Reset hunk" },
        { "<leader>sR", gitsigns.reset_buffer, desc = "Reset buffer" },
        { "<leader>sp", gitsigns.preview_hunk, desc = "Preview hunk" },
        { "<leader>sb", gitsigns.blame_line, desc = "Blame line" },

        -- Text objects
        { "ih", gitsigns.select_hunk, desc = "Select hunk", mode = { "o", "x" } },
      })
    end,
  })
end

return M

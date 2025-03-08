local M = {
  "lewis6991/gitsigns.nvim",
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  local gitsigns = require("gitsigns")

  gitsigns.setup({
    signs = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged = {
      add = { text = "┃" },
      change = { text = "┃" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false,
    linehl = false,
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 500,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      require("which-key").add({
        buffer = bufnr,
        {
          "]c",
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end,
          desc = "Jump to next hunk",
        },
        {
          "[c",
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end,
          desc = "Jump to previous hunk",
        },
        { "<leader>s", group = "Gitsigns" },
        { "<leader>ss", gitsigns.stage_hunk, desc = "Stage hunk" },
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

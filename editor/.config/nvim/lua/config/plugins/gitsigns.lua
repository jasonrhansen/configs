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
      -- Navigation: Smart hunk jumping (diff-aware)
      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { buffer = bufnr, desc = "Git: Next hunk" })

      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { buffer = bufnr, desc = "Git: Prev hunk" })

      -- Actions
      vim.keymap.set("n", "<leader>ss", gitsigns.stage_hunk, { buffer = bufnr, desc = "Git: Stage hunk" })
      vim.keymap.set("n", "<leader>sr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Git: Reset hunk" })
      vim.keymap.set("n", "<leader>sR", gitsigns.reset_buffer, { buffer = bufnr, desc = "Git: Reset buffer" })
      vim.keymap.set("n", "<leader>sp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Git: Preview hunk" })
      vim.keymap.set("n", "<leader>sb", gitsigns.blame_line, { buffer = bufnr, desc = "Git: Blame line" })

      -- Text objects (Inner Hunk)
      -- This allows for 'dih' (delete in hunk) or 'yih' (yank in hunk)
      vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, { buffer = bufnr, desc = "Git: Select hunk" })
    end,
  })
end

return M

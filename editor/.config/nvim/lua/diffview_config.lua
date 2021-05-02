local M = {}

local cb = require('diffview.config').diffview_callback

require('diffview').setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = true        -- Requires nvim-web-devicons
  },
  key_bindings = {
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["<leader>e"] = cb("toggle_files"),        -- Bring focus to the files panel
    },
    file_panel = {
      ["j"]         = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["<down>"]    = cb("next_entry"),
      ["k"]         = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<up>"]      = cb("prev_entry"),
      ["<cr>"]      = cb("select_entry"),       -- Open the diff for the selected entry.
      ["o"]         = cb("select_entry"),
      ["R"]         = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["<tab>"]     = cb("select_next_entry"),
      ["<s-tab>"]   = cb("select_prev_entry"),
      ["<leader>e"] = cb("focus_files"),
      ["<leader>b"] = cb("toggle_files"),
    }
  }
}

vim.api.nvim_set_keymap('n', '<leader>z', "<cmd>DiffviewOpen<CR>", {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>Z', "<cmd>DiffviewClose<CR>", {noremap=true, silent=true})

-- Integrate with Telescope git_commits to be able to open the selected commit with DiffViewOpen.
local action_state = require('telescope.actions.state')

local open_diff = function()
  local selected_entry = action_state.get_selected_entry()
  local value = selected_entry['value']
  -- close Telescope window properly prior to switching windows
  vim.api.nvim_win_close(0, true)
  vim.cmd('stopinsert')
  local cmd = 'DiffviewOpen ' .. value .. '~1..' .. value
  vim.cmd(cmd)
end

function M.git_commits()
  require('telescope.builtin').git_commits({
    attach_mappings = function(_, map)
      map('i', '<c-o>', open_diff)
      return true
    end
  })
end

vim.api.nvim_set_keymap('n', 'tG', "<cmd>lua require'diffview_config'.git_commits()<CR>", {noremap=true, silent=true})

return M

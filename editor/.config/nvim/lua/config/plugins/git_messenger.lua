local M = {
  "rhysd/git-messenger.vim",
  keys = {
    { "<leader>G", "<cmd>GitMessenger<cr>", desc = "Git: Open Messenger" },
  },
}

function M.config()
  vim.g.git_messenger_always_into_popup = true
  vim.g.git_messenger_no_default_mappings = true

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("jason-config", { clear = true }),
    pattern = "gitmessengerpopup",
    callback = function()
      local opts = { buffer = true, remap = true }

      -- Close with Escape
      vim.keymap.set("n", "<esc>", "q", opts)

      -- History Traversal: o (older) and O (newer)
      vim.keymap.set("n", "<C-o>", "o", { buffer = true, remap = true, desc = "History: Older" })
      vim.keymap.set("n", "<C-i>", "O", { buffer = true, remap = true, desc = "History: Newer" })
    end,
  })
end

return M

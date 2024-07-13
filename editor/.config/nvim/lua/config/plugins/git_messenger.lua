local M = {
  "rhysd/git-messenger.vim",
}

function M.config()
  require("which-key").add({
    { "<leader>G", "<cmd>GitMessenger<cr>", desc = "Git Messenger" },
  })

  vim.g.git_messenger_always_into_popup = true

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "jason-config",
    pattern = "gitmessengerpopup",
    callback = function()
      require("which-key").add({
        buffer = true,
        noremap = false,
        { "<esc>", "q", desc = "Close popup" },
        { "<C-o>", "o", desc = "Back in git history" },
        { "<C-i>", "O", desc = "Forward in git history" },
      })
    end,
  })
end

return M

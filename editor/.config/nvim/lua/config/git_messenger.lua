local wk = require("which-key")

wk.register({ ["<leader>G"] = { "<cmd>GitMessenger<cr>", "Git Messenger" } })

vim.g.git_messenger_always_into_popup = true

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "jason-config",
  pattern = "gitmessengerpopup",
  callback = function()
    wk.register({ ["<esc>"] = { "q", "Close popup" } }, { noremap = false, buffer = 0 })
    wk.register({ ["<C-o>"] = { "o", "Back in git history" } }, { noremap = false, buffer = 0 })
    wk.register({ ["<C-i>"] = { "O", "Forward in git history" } }, { noremap = false, buffer = 0 })
  end,
})

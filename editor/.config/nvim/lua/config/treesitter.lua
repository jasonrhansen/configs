local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

vim.api.nvim_set_keymap("", "<F8>", "<cmd>TSBufDisable highlight<CR>", {noremap=true, silent=true})
vim.api.nvim_set_keymap("", "<F9>", "<cmd>TSBufEnable highlight<CR>", {noremap=true, silent=true})

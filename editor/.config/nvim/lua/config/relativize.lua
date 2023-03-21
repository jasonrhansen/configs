-- Automatically toggle relative line numbers based on mode.
-- Based on https://github.com/ericbn/vim-relativize

local enabled = vim.o.relativenumber
local with_number = vim.o.number

local function set_numbers(relative)
  if enabled and (vim.o.number or vim.o.relativenumber) then
    vim.o.number = not relative or with_number
    vim.o.relativenumber = relative
  end
end

local function toggle()
  if enabled then
    set_numbers(false)
    enabled = false
  else
    enabled = true
    set_numbers(true)
  end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "FocusGained", "InsertLeave", "WinEnter", "TextYankPost" }, {
  group = "jason-config",
  pattern = { "*" },
  callback = function()
    set_numbers(true)
  end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = "jason-config",
  pattern = { "*" },
  callback = function()
    set_numbers(false)
  end,
})

local function toggle_line_numbers()
  vim.o.number = not vim.o.number and (with_number or enabled)
  vim.o.relativenumber = not vim.o.relativenumber and enabled
end

vim.api.nvim_create_user_command("RelativizeToggle", toggle, {})
vim.api.nvim_create_user_command("ToggleLineNumbers", toggle_line_numbers, {})

vim.api.nvim_set_keymap(
  "n",
  "<leader>L",
  ":RelativizeToggle<CR>",
  { desc = "Toggle Relativize", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>l",
  ":ToggleLineNumbers<CR>",
  { desc = "Toggle line numbers", noremap = true, silent = true }
)

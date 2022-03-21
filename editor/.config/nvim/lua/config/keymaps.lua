-- Misc. key maps defined with which-key

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    name = "Leader",
    ["<leader>"] = { "<c-^>", "Toggle between buffers" },
    ve = { "<cmd>vsplit $MYVIMRC<cr>", "Edit init.vim" },
    vs = { "<cmd>source $MYVIMRC<cr>", "Reload init.vim" },
    w = { "w!<cr>", "Save (force)" },
    c = { "<cmd>lua require'config.keymaps'.toggle_bright_comments()<cr>", "Toggle bright comments" },
    i = { "<cmd>IndentBlanklineToggle<cr>", "Toggle indent guides" },
    q = { "<cmd>Bdelete<cr>", "Delete buffer" },
    l = { "<cmd>lua require'config.keymaps'.toggle_line_numbers()<cr>", "Toggle line numbers" },
    L = { "<cmd>RelativizeToggle<cr>", "Toggle Relativize" },
    g = { "<cmd>lua require'config.keymaps'.toggle_global_statusline()<cr>", "Toggle global statusline" },
    n = {
      name = "NG Switcher",
      t = { "<cmd>NgSwitchTS<cr>", "Switch to TS" },
      c = { "<cmd>NgSwitchCSS<cr>", "Switch to CSS/SCSS" },
      h = { "<cmd>NgSwitchHTML<cr>", "Switch to HTML" },
      S = { "<cmd>NgSwitchSpec<cr>", "Switch to Spec" },
      s = {
        name = "NG Switcher (horizontal split)",
        t = { "<cmd>SNgSwitchTS<cr>", "Switch to TS (horizontal split)" },
        c = { "<cmd>SNgSwitchCSS<cr>", "Switch to CSS/SCSS (horizontal split)" },
        h = { "<cmd>SNgSwitchHTML<cr>", "Switch to HTML (horizontal split)" },
        S = { "<cmd>SNgSwitchSpec<cr>", "Switch to Spec (horizontal split)" },
      },
      v = {
        name = "NG Switcher (vertical split)",
        t = { "<cmd>VNgSwitchTS<cr>", "Switch to TS (vertical split)" },
        c = { "<cmd>VNgSwitchCSS<cr>", "Switch to CSS/SCSS (vertical split)" },
        h = { "<cmd>VNgSwitchHTML<cr>", "Switch to HTML (vertical split)" },
        S = { "<cmd>VNgSwitchSpec<cr>", "Switch to Spec (vertical split)" },
      },
    },
  },
})

local M = {}

function M.toggle_line_numbers()
  vim.o.number = not vim.o.number and (vim.g.relativize_with_number == 1 or vim.g.relativize_enabled == 1)
  vim.o.relativenumber = not vim.o.relativenumber and vim.g.relativize_enabled == 1
end

local bright_comments = false
function M.toggle_bright_comments()
  bright_comments = not bright_comments
  if bright_comments then
    vim.cmd([[ hi Comment guifg=#9ca5cf ]])
  else
    vim.cmd([[ hi Comment guifg=#565F89 ]])
  end
end

function M.toggle_global_statusline()
  if vim.go.laststatus ~= 3 then
    vim.go.laststatus = 3
  else
    vim.go.laststatus = 2
  end
end

return M

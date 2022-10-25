-- Misc. key maps defined with which-key

local wk = require("which-key")

-- Normal mode leader mappings
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
    W = { "<cmd>lua require'config.keymaps'.toggle_winbar()<cr>", "Toggle winbar" },
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

-- Turn off search highlights by pressing return unless in quickfix window.
wk.register({
  ["<cr>"] = { '&buftype ==# "quickfix" ? "<CR>" : ":noh<cr>"', "Turn off search highlights", expr = true },
})

-- Add a 'stamp' command to replace word or selection with yanked text.
wk.register({ ["<leader>p"] = { '"_diwP', '"Stamp" yanked text' } }, { mode = "n" })
wk.register({ ["<leader>p"] = { '"_dP', '"Stamp" yanked text' } }, { mode = "v" })

-- Make 'Y' work from the cursor to end of line instead of like 'yy'.
wk.register({ Y = { "y$", "Yank to end of line" } })

-- Reselect visual selection after indent.
wk.register({
  ["<"] = { "<gv", "Indent left and reselect" },
  [">"] = { ">gv", "Indent right and reselect" },
}, { mode = "x" })

-- Create newlines like o and O but stay in normal mode.
wk.register({
  ["zj"] = { "o<Esc>k", "Newline below" },
  ["zk"] = { "O<Esc>j", "Newline above" },
})

-- Center the screen when jumping through the changelist.
wk.register({
  ["g;"] = { "g;zz", "Next in changelist, and center" },
  ["g,"] = { "g,z", "Previous in changelist, and center" },
})

-- This makes j and k work on "screen lines" instead of on "file lines"; now, when
-- we have a long line that wraps to multiple screen lines, j and k behave as we
-- expect them to.
wk.register({
  ["j"] = { "gj", "Cursor down" },
  ["k"] = { "gk", "Cursor up" },
})

-- Swap implementations of ` and ' jump to markers.
-- By default, ' jumps to the marked line, ` jumps to the marked line and
-- column, so swap them
wk.register({
  ["'"] = { "`", "Jump to mark" },
  ["`"] = { "'", "Jump to marked line" },
})

-- Don't move cursor when joining lines.
wk.register({ J = { "mzJ`z", "Join lines" } })

-- Add undo break points for punctuation.
wk.register({
  [","] = { ",<C-g>u", ", with undo breakpoint" },
  ["."] = { ".<C-g>u", ". with undo breakpoint" },
  ["!"] = { "!<C-g>u", "! with undo breakpoint" },
  ["?"] = { "?<C-g>u", "? with undo breakpoint" },
}, { mode = "i" })

-- Move lines up and down, and re-indent.
wk.register({
  ["<m-k>"] = { ":m .-2<cr>==", "Move line up" },
  ["<m-j>"] = { ":m .+1<cr>==", "Move line down" },
}, { mode = "n" })
wk.register({
  ["<m-k>"] = { "<esc>:m .-2<cr>==", "Move line up" },
  ["<m-j>"] = { "<esc>:m .+1<cr>==", "Move line down" },
}, { mode = "i" })
wk.register({
  ["<m-k>"] = { ":m '<-2<cr>gv=gv", "Move lines up" },
  ["<m-j>"] = { ":m '>+1<cr>gv=gv", "Move lines down" },
}, { mode = "v" })

-- Exit insert mode and save just by hitting CTRL-s.
wk.register({ ["<C-s>"] = { "<esc>:w<cr>", "Exit insert mode and save" } }, { mode = "n", noremap = false })
wk.register({ ["<C-s>"] = { "<esc>:w<cr>", "Exit insert mode and save" } }, { mode = "i", noremap = false })

-- I never use the command line window on purpose, but I do open it sometimes
-- on accident when trying to get to the command line, so make q: open the command line.
wk.register({ ["q:"] = { ":", "Open command line" } }, { silent = false })

-- With this map, we can select some text in visual mode and by invoking the map,
-- have the selection automatically filled in as the search text and the cursor
-- placed in the position for typing the replacement text. Also, this will ask
-- for confirmation before it replaces any instance of the search text in the file.
wk.register({ ["<C-r>"] = { '"hy:%s/<C-r>h//gc<left><left><left>', "Substitute with selection" } }, { mode = "v", silent = false })

local M = {}

function M.toggle_line_numbers()
  vim.o.number = not vim.o.number and (vim.g.relativize_with_number == 1 or vim.g.relativize_enabled == 1)
  vim.o.relativenumber = not vim.o.relativenumber and vim.g.relativize_enabled == 1
end

local bright_comments = false
function M.toggle_bright_comments()
  bright_comments = not bright_comments
  if bright_comments then
    vim.cmd([[ hi Comment guifg=#a2a199 ]])
  else
    vim.cmd([[ hi Comment guifg=#727169 ]])
  end
end

function M.toggle_global_statusline()
  if vim.go.laststatus ~= 3 then
    vim.go.laststatus = 3
  else
    vim.go.laststatus = 2
  end
end

M.saved_winbar = vim.go.winbar

function M.toggle_winbar()
  if vim.go.winbar == nil or vim.go.winbar == "" then
    vim.go.winbar = M.saved_winbar
  else
    M.saved_winbar = vim.go.winbar
    vim.go.winbar = nil
  end
end

return M

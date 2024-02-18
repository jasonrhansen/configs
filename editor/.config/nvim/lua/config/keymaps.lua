-- Misc. key maps defined with which-key

local comment_colors = { vim.fn.synIDattr(vim.fn.hlID("Comment"), "fg#"), "#a2a199" }
local comment_color_index = 0
local function toggle_bright_comments()
  comment_color_index = (comment_color_index + 1) % #comment_colors
  vim.cmd.hi("Comment guifg=" .. comment_colors[comment_color_index + 1])
end

local function toggle_global_statusline()
  if vim.go.laststatus ~= 3 then
    vim.go.laststatus = 3
  else
    vim.go.laststatus = 2
  end
end

local saved_winbar = vim.go.winbar
local function toggle_winbar()
  if vim.wo.winbar == nil or vim.wo.winbar == "" then
    vim.wo.winbar = saved_winbar
  else
    saved_winbar = vim.wo.winbar
    vim.wo.winbar = nil
  end
end

local function toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

local wk = require("which-key")
local pick_window = require("util").pick_window

-- Normal mode leader mappings
wk.register({
  ["<leader>"] = {
    name = "Leader",
    ["<leader>"] = { "<c-^>", "Toggle between buffers" },
    ve = { "<cmd>vsplit $MYVIMRC<cr>", "Edit init.vim" },
    vs = { "<cmd>source $MYVIMRC<cr>", "Reload init.vim" },
    w = { "w!<cr>", "Save (force)" },
    q = { "<cmd>Bdelete<cr>", "Delete buffer" },
    t = {
      name = "Toggle",
      b = { toggle_bright_comments, "Toggle bright comments" },
      g = { toggle_global_statusline, "Toggle global statusline" },
      W = { toggle_winbar, "Toggle winbar" },
      i = { "<cmd>IBLToggle<cr>", "Toggle indent guides" },
      q = { toggle_quickfix, "Toggle indent guides" },
    },
    n = {
      name = "NG Switcher",
      t = { "<cmd>NgSwitchTS<cr>", "Switch to TS" },
      c = { "<cmd>NgSwitchCSS<cr>", "Switch to CSS/SCSS" },
      h = { "<cmd>NgSwitchHTML<cr>", "Switch to HTML" },
      S = { "<cmd>NgSwitchSpec<cr>", "Switch to Spec" },
      n = {
        name = "NG Switcher (pick window)",
        t = { pick_window("NgSwitchTS"), "Switch to TS (pick window)" },
        c = { pick_window("NgSwitchCSS"), "Switch to CSS/SCSS (pick window)" },
        h = { pick_window("NgSwitchHTML"), "Switch to HTML (pick window)" },
        s = { pick_window("NgSwitchSpec"), "Switch to Spec (pick window)" },
      },
    },
  },
})

-- Turn off search highlights by pressing return unless in quickfix window.
wk.register({
  ["<cr>"] = { '&buftype ==# "quickfix" ? "<CR>" : ":noh<cr>"', "Turn off search highlights", expr = true },
})

-- Add a 'stamp' command to replace word or selection with yanked text.
vim.keymap.set("n", "<Plug>StampYankedText", '"_diwP:call repeat#set("\\<Plug>StampYankedText")<CR>', { silent = true })
wk.register({ ["<leader>p"] = { "<Plug>StampYankedText", '"Stamp" yanked text' } }, { mode = "n" })
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

-- Don't move cursor when joining lines. Also add a version that removes spaces between joined lines that's dot-repeatable.
wk.register({ J = { "mzJ`z", "Join lines" } })
vim.keymap.set(
  "n",
  "<Plug>JoinLinesWithoutSpaces",
  'mzJx`z:call repeat#set("\\<Plug>JoinLinesWithoutSpaces")<CR>',
  { silent = true }
)
wk.register({ ["<leader>J"] = { "<Plug>JoinLinesWithoutSpaces", "Join lines without space" } })

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
wk.register(
  { ["<C-r>"] = { '"hy:%s/<C-r>h//gc<left><left><left>', "Substitute with selection" } },
  { mode = "v", silent = false }
)

local function is_window_rightmost(winnr)
  winnr = winnr or vim.fn.winnr()
  return vim.o.columns == vim.fn.win_screenpos(winnr)[2] + vim.fn.winwidth(winnr) - 1
end

local function adjust_window_width(cols)
  if is_window_rightmost() then
    cols = -cols
  end

  if cols > 0 then
    vim.cmd("vertical resize +" .. cols)
  else
    vim.cmd("vertical resize -" .. -cols)
  end
end

-- Quickly adjust window width.
wk.register({
  ["<M-l>"] = {
    function()
      adjust_window_width(5)
    end,
    "Adjust window width right",
  },
  ["<M-h>"] = {
    function()
      adjust_window_width(-5)
    end,
    "Adjust window width left",
  },
})

local function show_documentation()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand("<cword>"))
  elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
    require("crates").show_popup()
    require("crates").focus_popup()
  else
    vim.lsp.buf.hover()
  end
end

wk.register({
  ["<leader>K"] = { show_documentation, "Show documentation", { silent = true } },
})

wk.register({
  ["<leader>yf"] = { '<cmd>lua require("util").copy_to_clipboard(vim.fn.expand("%:t"))<cr>', "Copy file name" },
  ["<leader>yp"] = { '<cmd>lua require("util").copy_to_clipboard(vim.fn.expand("%:p"))<cr>', "Copy file path" },
  ["<leader>yd"] = { '<cmd>lua require("util").copy_to_clipboard(vim.fn.expand("%:p:h"))<cr>', "Copy directory path" },
})

local function remove_quickfix_item()
  local qf = vim.fn.getqflist()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1]
  table.remove(qf, line)
  vim.fn.setqflist(qf)
  local last_line = vim.fn.line("$")
  vim.api.nvim_win_set_cursor(0, { math.min(cursor[1], last_line), cursor[2] })
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "jason-config",
  pattern = { "qf" },
  callback = function()
    wk.register({
      ["dd"] = { remove_quickfix_item, "Remove item from quickfix list", { silent = true } },
    })
  end,
})

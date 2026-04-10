local pick_window = require("util").pick_window
local util = require("util")

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

local function remove_quickfix_items(start, finish)
  if finish == nil then
    finish = start
  end
  start, finish = unpack({ math.min(start, finish), math.max(start, finish) })
  local qf = vim.fn.getqflist()
  for i = finish, start, -1 do
    table.remove(qf, i)
  end
  vim.fn.setqflist(qf)
  local last_line = vim.fn.line("$")
  vim.api.nvim_win_set_cursor(0, { math.min(start, last_line), vim.api.nvim_win_get_cursor(0)[2] })
end

require("which-key").add({
  { "<leader>", group = "Leader" },
})

-- General / Buffer Navigation
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Buffer: Toggle previous" })
vim.keymap.set("n", "<leader>w", "<cmd>w!<cr>", { desc = "File: Force save" })

-- Toggles
vim.keymap.set("n", "<leader>tb", toggle_bright_comments, { desc = "Toggle: Bright comments" })
vim.keymap.set("n", "<leader>tg", toggle_global_statusline, { desc = "Toggle: Global statusline" })
vim.keymap.set("n", "<leader>tW", toggle_winbar, { desc = "Toggle: Winbar" })
vim.keymap.set("n", "<leader>tq", toggle_quickfix, { desc = "Toggle: Quickfix/Indent guides" })
vim.keymap.set("n", "<leader>tc", "<cmd>TSContextToggle<cr>", { desc = "Toggle: Treesitter context" })

-- Diagnostic navigattion
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev Diagnostic" })

-- Intelligent <CR> Handling
-- Clears search highlights unless we are in a Quickfix buffer
vim.keymap.set("n", "<CR>", function()
  if vim.bo.buftype == "quickfix" then
    return "<CR>"
  end
  vim.cmd.noh()
  return "<CR>"
end, { expr = true, desc = "Clear search highlights" })

-- Exit insert mode without reaching.
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Visual Mode Indenting
-- Keeps the selection active so you can tap > or < multiple times
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Navigation on wrapped lines (Screen lines vs File lines)
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Marker Swap (Line vs Column)
vim.keymap.set("n", "'", "`", { desc = "Jump to mark (col/line)" })
vim.keymap.set("n", "`", "'", { desc = "Jump to mark (line start)" })

-- Insert Mode Undo Breakpoints
-- These allow you to undo small chunks of text rather than the whole paragraph
local punctuation = { ",", ".", "!", "?" }
for _, char in ipairs(punctuation) do
  vim.keymap.set("i", char, char .. "<C-g>u")
end

-- Move Lines Up/Down
vim.keymap.set("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("i", "<M-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
vim.keymap.set("i", "<M-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move lines up" })
vim.keymap.set("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move lines down" })

-- Save via CTRL-s
vim.keymap.set({ "n", "i" }, "<C-s>", "<esc><cmd>w<cr>", { desc = "Save file" })

-- Prevent the accidental 'q:' command-line window
-- This maps the "accidental" key to the "intended" key
vim.keymap.set("n", "q:", ":", { silent = false })

-- Search & Replace Visual Selection
-- High-speed substitution using the 'h' register as a temporary buffer
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', {
  desc = "Substitute selection",
  silent = false,
})

-- Adjust window width
vim.keymap.set("n", "<M-l>", function()
  adjust_window_width(5)
end, { desc = "Adjust window width right" })
vim.keymap.set("n", "<M-h>", function()
  adjust_window_width(-5)
end, { desc = "Adjust window width left" })

-- LSP Documentation
vim.keymap.set("n", "<leader>K", show_documentation, { desc = "LSP: Show documentation", silent = true })

-- Set CWD to project root
vim.keymap.set("n", "<leader>cr", util.set_project_root, { desc = "Set CWD to project root" })

--------------------------------------------------------------------------------
-- Clipboard Utilities
--------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>cf", function()
  local val = vim.fn.expand("%:t")
  util.copy_to_clipboard(val)
  print("Copied file name: " .. val)
end, { desc = "Copy: File name" })

vim.keymap.set("n", "<leader>cp", function()
  local val = vim.fn.expand("%:p")
  util.copy_to_clipboard(val)
  print("Copied file path: " .. val)
end, { desc = "Copy: Full path" })

vim.keymap.set("n", "<leader>cd", function()
  local val = vim.fn.expand("%:p:h")
  util.copy_to_clipboard(val)
  print("Copied directory: " .. val)
end, { desc = "Copy: Directory path" })

--------------------------------------------------------------------------------
-- "Stamp" Logic (Replace with Register)
--------------------------------------------------------------------------------

-- Normal mode: uses <Plug> for dot-repeatability via vim-repeat
vim.keymap.set("n", "<Plug>StampYankedText", '"_diwP', { silent = true })
vim.keymap.set("n", "<leader>p", "<Plug>StampYankedText", {
  desc = "Stamp: Replace word with yanked",
  remap = true,
})

-- Visual mode: simple replacement without losing the yanked register
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Stamp: Replace selection" })

--------------------------------------------------------------------------------
-- Line Joining (Cursor Stable)
--------------------------------------------------------------------------------
-- J: Join lines but keep cursor position using marks
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (stable cursor)" })

-- <leader>J: Join lines and delete the resulting space (dot-repeatable)
vim.keymap.set("n", "<Plug>JoinLinesWithoutSpaces", "mzJx`z", { silent = true })
vim.keymap.set("n", "<leader>J", "<Plug>JoinLinesWithoutSpaces", {
  desc = "Join lines (no space)",
  remap = true,
})

-- Easily remove items from the quickfix list
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "jason-config",
  pattern = { "qf" },
  callback = function()
    vim.keymap.set("n", "dd", function()
      remove_quickfix_items(vim.api.nvim_win_get_cursor(0)[1])
    end, {
      buffer = true,
      desc = "Remove item from quickfix list",
    })
    vim.keymap.set("v", "d", function()
      remove_quickfix_items(vim.fn.line("."), vim.fn.line("v"))
      vim.api.nvim_feedkeys("<esc>", "n", true)
    end, {
      buffer = true,
      desc = "Remove selected items from quickfix list",
    })
  end,
})

-- Toggle undotree window
vim.keymap.set("n", "<leader>u", function()
  require("undotree").open({ command = "50vnew" })
end, { desc = "Toggle undotree window" })

--------------------------------------------------------------------------------
-- Treesitter incremental selection
--------------------------------------------------------------------------------

vim.keymap.set({ "n", "x", "o" }, "<A-o>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

vim.keymap.set({ "n", "x", "o" }, "<A-i>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })

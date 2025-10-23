local wk = require("which-key")
local pick_window = require("util").pick_window

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

wk.add({
  { "<leader>", group = "Leader" },
  { "<leader><leader>", "<c-^>", desc = "Toggle between buffers" },
  { "<leader>ve", "<cmd>vsplit $MYVIMRC<cr>", desc = "Edit init.vim" },
  { "<leader>vs", "<cmd>source $MYVIMRC<cr>", desc = "Reload init.vim" },
  { "<leader>w", "w!<cr>", desc = "Save (force)" },
  { "<leader>t", group = "Toggle" },
  { "<leader>tb", toggle_bright_comments, desc = "Toggle bright comments" },
  { "<leader>tg", toggle_global_statusline, desc = "Toggle global statusline" },
  { "<leader>tW", toggle_winbar, desc = "Toggle winbar" },
  { "<leader>tq", toggle_quickfix, desc = "Toggle indent guides" },
  { "<leader>tc", "<cmd>TSContextToggle<cr>", desc = "Toggle treesitter context" },
  { "<leader>n", group = "NG Switcher" },
  { "<leader>nt", "<cmd>NgSwitchTS<cr>", desc = "Switch to TS" },
  { "<leader>nc", "<cmd>NgSwitchCSS<cr>", desc = "Switch to CSS/SCSS" },
  { "<leader>nh", "<cmd>NgSwitchHTML<cr>", desc = "Switch to HTML" },
  { "<leader>nS", "<cmd>NgSwitchSpec<cr>", desc = "Switch to Spec" },
  { "<leader>nn", group = "NG Switcher (pick window)" },
  { "<leader>nnt", pick_window("NgSwitchTS"), desc = "Switch to TS (pick window)" },
  { "<leader>nnc", pick_window("NgSwitchCSS"), desc = "Switch to CSS/SCSS (pick window)" },
  { "<leader>nnh", pick_window("NgSwitchHTML"), desc = "Switch to HTML (pick window)" },
  { "<leader>nns", pick_window("NgSwitchSpec"), desc = "Switch to Spec (pick window)" },

  -- Jump to diagnostics and open diagnostic float.
  {
    "]d",
    function()
      vim.diagnostic.jump({ float = true, count = 1 })
    end,
    desc = "Jump to next diagnostic in current buffer",
  },
  {
    "[d",
    function()
      vim.diagnostic.jump({ float = true, count = -1 })
    end,
    desc = "Jump to next diagnostic in current buffer",
  },

  -- Turn off search highlights by pressing return unless in quickfix window.
  {
    "<cr>",
    function()
      if vim.o.buftype ~= "quickfix" then
        vim.cmd.noh()
        print(" ") -- Clear cmdline
      else
        local key = vim.api.nvim_replace_termcodes("<cr>", true, false, true)
        vim.api.nvim_feedkeys(key, "n", false)
      end
    end,
    desc = "Turn off search highlights",
  },

  -- Make 'Y' work from the cursor to end of line instead of like 'yy'.
  { "Y", "y$", desc = "Yank to end of line" },

  -- This makes j and k work on "screen lines" instead of on "file lines"; now, when
  -- we have a long line that wraps to multiple screen lines, j and k behave as we
  -- expect them to.
  { "j", "gj", desc = "Cursor down", hidden = true },
  { "k", "gk", desc = "Cursor up", hidden = true },

  -- Swap implementations of ` and ' jump to markers.
  -- By default, ' jumps to the marked line, ` jumps to the marked line and
  -- column, so swap them
  { "'", "`", desc = "Jump to mark", hidden = true },
  { "`", "'", desc = "Jump to marked line", hidden = true },

  -- Reselect visual selection after indent.
  {
    mode = "x",
    { "<", "<gv", desc = "Indent left and reselect", hidden = true },
    { ">", ">gv", desc = "Indent right and reselect", hidden = true },
  },

  -- Add undo break points for punctuation.
  {
    mode = "i",
    { ",", ",<C-g>u", desc = ", with undo breakpoint", hidden = true },
    { ".", ".<C-g>u", desc = ". with undo breakpoint", hidden = true },
    { "!", "!<C-g>u", desc = "! with undo breakpoint", hidden = true },
    { "?", "?<C-g>u", desc = "? with undo breakpoint", hidden = true },
  },

  -- Move lines up and down, and re-indent.
  {
    mode = "n",
    { "<m-k>", ":m .-2<cr>==", desc = "Move line up" },
    { "<m-j>", ":m .+1<cr>==", desc = "Move line down" },
  },
  {
    mode = "i",
    { "<m-k>", "<esc>:m .-2<cr>==", desc = "Move line up" },
    { "<m-j>", "<esc>:m .+1<cr>==", desc = "Move line down" },
  },
  {
    mode = "v",
    { "<m-k>", ":m '<-2<cr>gv=gv", desc = "Move lines up" },
    { "<m-j>", ":m '>+1<cr>gv=gv", desc = "Move lines down" },
  },

  -- Exit insert mode and save just by hitting CTRL-s.
  { "<C-s>", "<esc>:w<cr>", desc = "Exit insert mode and save", mode = "n", noremap = false },
  { "<C-s>", "<esc>:w<cr>", desc = "Exit insert mode and save", mode = "i", noremap = false },

  -- I never use the command line window on purpose, but I do open it sometimes
  -- on accident when trying to get to the command line, so make q: open the command line.
  { "q:", ":", desc = "Open command line", silent = false },

  -- With this map, we can select some text in visual mode and by invoking the map,
  -- have the selection automatically filled in as the search text and the cursor
  -- placed in the position for typing the replacement text. Also, this will ask
  -- for confirmation before it replaces any instance of the search text in the file.
  { "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', desc = "Substitute with selection", mode = "v", silent = false },

  -- Quickly adjust window width.
  {
    "<M-l>",
    function()
      adjust_window_width(5)
    end,
    desc = "Adjust window width right",
  },
  {
    "<M-h>",
    function()
      adjust_window_width(-5)
    end,
    desc = "Adjust window width left",
  },

  { "<leader>K", show_documentation, desc = "Show documentation", silent = true },
  -- Copy file and directory names to clipboard
  { "<leader>cf", '<cmd>lua require("util").copy_to_clipboard(vim.fn.expand("%:t"))<cr>', desc = "Copy file name" },
  { "<leader>cp", '<cmd>lua require("util").copy_to_clipboard(vim.fn.expand("%:p"))<cr>', desc = "Copy file path" },
  {
    "<leader>cd",
    '<cmd>lua require("util").copy_to_clipboard(vim.fn.expand("%:p:h"))<cr>',
    desc = "Copy directory path",
  },
  {
    "<leader>cf",
    function()
      require("util").copy_to_clipboard(vim.fn.expand("%:t"))
      print("Copied file name to system clipboard")
    end,
    desc = "Copy file name",
  },
  {
    "<leader>cp",
    function()
      require("util").copy_to_clipboard(vim.fn.expand("%:p"))
      print("Copied file path to system clipboard")
    end,
    desc = "Copy file path",
  },
  {
    "<leader>cd",
    function()
      require("util").copy_to_clipboard(vim.fn.expand("%:p:h"))
      print("Copied directory to system clipboard")
    end,
    desc = "Copy directory path",
  },

  -- Add a 'stamp' command to replace word or selection with yanked text.
  { "<Plug>StampYankedText", '"_diwP:call repeat#set("\\<Plug>StampYankedText")<CR>', hidden = true, silent = true },
  { "<leader>p", "<Plug>StampYankedText", desc = '"Stamp" yanked text' },
  { "<leader>p", '"_dP', desc = '"Stamp" yanked text', mode = "v" },

  -- Don't move cursor when joining lines. Also add a version that removes spaces between joined lines that's dot-repeatable.
  { "J", "mzJ`z", desc = "Join lines" },

  -- Join lines without spaces
  {
    "<Plug>JoinLinesWithoutSpaces",
    'mzJx`z:call repeat#set("\\<Plug>JoinLinesWithoutSpaces")<CR>',
    hidden = true,
    silent = true,
  },
  { "<leader>J", "<Plug>JoinLinesWithoutSpaces", desc = "Join lines without space" },
})

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

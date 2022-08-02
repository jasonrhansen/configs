local opt = vim.opt

opt.backup = false
opt.breakindent = true
opt.breakindentopt = "sbr"
opt.cursorline = false
opt.errorbells = false
opt.foldenable = false
opt.foldmethod = "marker"
opt.history = 1000
opt.ignorecase = true
opt.laststatus = 3 -- Global statusline
opt.linebreak = true -- Break properly, don't split words
opt.list = false
opt.listchars = { tab = "▸ ", extends = "❯", nbsp = "␣", precedes = "❮" }
opt.modeline = false -- Use securemodelines instead
opt.mouse = "a" -- Enable mouse in all modes
opt.mousemodel = "popup_setpos" -- Right-click on selection should bring up a menu
opt.number = true
opt.redrawtime = 10000 -- Still show syntax highlighting for really large files.
opt.relativenumber = false
opt.scrolloff = 4 -- Show context above/below cursorline
opt.secure = true
opt.shiftround = true
opt.shortmess:append({ c = true }) -- Don't give ins-completion-menu messages
opt.showbreak = "↳ "
opt.showfulltag = true
opt.showmatch = true
opt.showmode = false -- Lualine shows the mode
opt.sidescrolloff = 5
opt.signcolumn = "yes" -- Always show signcolumns
opt.smartcase = true
opt.swapfile = false
opt.textwidth = 0
opt.timeoutlen = 500
opt.title = true
opt.undodir = vim.fn.expand("~/.vim/tmp/undo//") -- Undo files
opt.undofile = true
opt.undolevels = 1000
opt.updatetime = 100 -- You will have bad experience for diagnostic messages when it's default 4000.
opt.visualbell = true
opt.wildchar = string.byte("\t")
opt.wildignorecase = true
opt.wildmode = { "longest", "list", "full" }
opt.writebackup = false

-- Indentation
opt.expandtab = true -- Indent with spaces
opt.shiftwidth = 2 -- Number of spaces to use when indenting
opt.smartindent = true -- Auto indent new lines
opt.softtabstop = 2 -- Number of spaces a <tab> counts for when inserting
opt.tabstop = 2 -- Number of spaces a <tab> counts for

-- Session and view options to save
opt.sessionoptions = { "buffers", "folds", "tabpages", "curdir", "globals" }
opt.viewoptions = { "cursor", "folds" }

if vim.fn.has("unnamedplus") then
  -- By default, Vim will not use the system clipboard when yanking/pasting to
  -- the default register. This option makes Vim use the system default
  -- clipboard.
  -- Note that on X11, there are _two_ system clipboards: the 'standard' one, and
  -- the selection/mouse-middle-click one. Vim sees the standard one as register
  -- '+' (and this option makes Vim use it by default) and the selection one as
  -- '*'.
  -- See :h 'clipboard' for details.
  opt.clipboard = { "unnamedplus", "unnamed" }
else
  -- Vim now also uses the selection system clipboard for default yank/paste.
  opt.clipboard:append({ "unnamed" })
end

-- This feels more natural
opt.splitbelow = true
opt.splitright = true

vim.g.mapleader = " "
vim.g.maplocalleader = "-"

-- Detect binary file or large file automatically
vim.g.vinarise_enable_auto_detect = 1

vim.cmd.syntax("on")
vim.cmd("syntax sync minlines=256") -- Increase scrolling performance

vim.g.python_host_prog = vim.fn.trim(vim.fn.system("which python2"))
vim.g.python3_host_prog = vim.fn.trim(vim.fn.system("which python3"))

-- Make those folders automatically if they don't already exist.
if not vim.fn.isdirectory(vim.fn.expand(vim.o.undodir)) then
  vim.fn.mkdir(vim.fn.expand(vim.o.undodir), "p")
end
if not vim.fn.isdirectory(vim.fn.expand(vim.o.directory)) then
  vim.fn.mkdir(vim.fn.expand(vim.o.directory), "p")
end

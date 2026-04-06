local opt = vim.opt

-- General Logic
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/tmp/undo//")
opt.sessionoptions = { "buffers", "folds", "tabpages", "curdir", "globals", "localoptions" }

-- UI Aesthetics
opt.number = true
opt.relativenumber = false
opt.cursorline = false
opt.signcolumn = "yes" -- Always show signcolumns
opt.laststatus = 3      -- Global statusline
opt.termguicolors = true
opt.winborder = "rounded"
opt.showmode = false    -- Lualine/Snacks handles this

-- Searching & Case
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true

-- Mouse & Clipboard
opt.mouse = "a"
opt.mousemodel = "popup_setpos" -- Right-click on selection should bring up a menu
opt.clipboard = "unnamedplus" -- Native OSC 52 handles SSH automatically if setup correctly

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftround = true

-- Scrolling & Splits
opt.scrolloff = 8
opt.smoothscroll = true
opt.sidescrolloff = 5
opt.splitbelow = true
opt.splitright = true

-- Performance & Timeouts
opt.updatetime = 100
opt.timeoutlen = 300
opt.redrawtime = 1500 -- No need for 10000 with Tree-sitter efficiency

-- Formatting & Text
opt.breakindent = true
opt.linebreak = true
opt.textwidth = 0

-- Global Variables
vim.g.mapleader = " "
vim.g.maplocalleader = "-"

-- Navigation & Command Line
opt.wildmode = { "longest", "list", "full" }
opt.history = 1000
opt.title = true

-- Visuals & Wrapping
opt.breakindentopt = "sbr"
opt.showbreak = "↳ "
opt.list = false
opt.listchars = { tab = "▸ ", extends = "❯", nbsp = "␣", precedes = "❮" }

-- Diff & Undo
opt.diffopt:append({ "vertical" })
opt.undolevels = 1000

-- Behavior & Silence
opt.shortmess:append({ c = true, I = true })
opt.showfulltag = true
opt.modeline = false

-- Folds
opt.foldenable = false
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Session and view options to save
opt.viewoptions = { "cursor", "folds" }

opt.errorbells = false
opt.secure = true
opt.showmatch = true
opt.visualbell = true

vim.cmd.syntax("on")

vim.g.python3_host_prog = vim.fn.trim(vim.fn.system("which python3"))

-- Make sure these directories are created if they don't already exist.
local data_dirs = {
  vim.fn.expand(vim.opt.undodir:get()[1]),
  vim.fn.expand(vim.opt.directory:get()[1]),
}

for _, dir in ipairs(data_dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

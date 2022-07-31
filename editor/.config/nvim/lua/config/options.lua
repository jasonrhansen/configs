local opt = vim.opt

opt.compatible = false
opt.encoding = "utf-8"
opt.hidden = true
opt.wildmenu = true
opt.wildchar = string.byte("\t")
opt.wildmode = { "longest", "list", "full" }
opt.wildignorecase = true
opt.showfulltag = true
opt.history = 1000
opt.ignorecase = true
opt.smartcase = true
opt.title = true
opt.ruler = true
opt.backspace = { "indent", "eol", "start" }
opt.incsearch = true
opt.foldmethod = "marker"
opt.foldenable = false
opt.textwidth = 0
opt.undolevels = 1000
opt.showcmd = true
opt.showmatch = true
opt.number = true
opt.relativenumber = false
opt.cursorline = false
opt.autoread = true
opt.background = "dark"
opt.breakindent = true
opt.breakindentopt = "sbr"
opt.list = false
opt.listchars = { tab = "▸ ", extends = "❯", nbsp = "␣", precedes = "❮" }
opt.fillchars = { vert = "|" }
opt.linebreak = true -- Break properly, don't split words
opt.scrolloff = 4 -- Show context above/below cursorline
opt.formatoptions:append({ "j" })
opt.sidescrolloff = 5
opt.shiftround = true
opt.startofline = false
opt.laststatus = 3 -- Global statusline
opt.errorbells = false
opt.visualbell = true
opt.secure = true
opt.modeline = false -- Use securemodelines instead
opt.showmode = false -- Lualine shows the mode
opt.updatetime = 100 -- You will have bad experience for diagnostic messages when it's default 4000.
opt.shortmess:append({ c = true }) -- Don't give ins-completion-menu messages
opt.signcolumn = "yes" -- Always show signcolumns
opt.undofile = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.timeoutlen = 500
opt.mouse = "a" -- Enable mouse in all modes
opt.mousemodel = "popup_setpos" -- Right-click on selection should bring up a menu
opt.redrawtime = 10000 -- Still show syntax highlighting for really large files.
opt.undodir = "~/.vim/tmp/undo//" -- Undo files

-- Indentation
opt.expandtab = true -- Indent with spaces
opt.shiftwidth = 2 -- Number of spaces to use when indenting
opt.smartindent = true -- Auto indent new lines
opt.softtabstop = 2 -- Number of spaces a <tab> counts for when inserting
opt.tabstop = 2 -- Number of spaces a <tab> counts for

-- Session and view options to save
opt.sessionoptions = { "buffers", "folds", "tabpages", "curdir", "globals" }
opt.viewoptions = { "cursor", "folds" }

-- This feels more natural
opt.splitbelow = true
opt.splitright = true

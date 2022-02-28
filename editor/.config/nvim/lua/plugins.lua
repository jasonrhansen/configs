-- On a new machine packer can be installed by cloning the repo:
-- git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

-- Automatically compile packer config when changes are made to this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer = require("packer")
local use = packer.use

packer.init()

-- Packer can manage itself
use("wbthomason/packer.nvim")

-- LSP
use("neovim/nvim-lspconfig")
use("nvim-lua/lsp-status.nvim")
use("folke/trouble.nvim")
use({
  "kosayoda/nvim-lightbulb",
  config = function()
    vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
  end,
})
use({
  "j-hui/fidget.nvim",
  config = function()
    require("fidget").setup({
      text = {
        spinner = "circle_halves",
      },
    })
  end,
})

-- Show function signature when you type
use({
  "ray-x/lsp_signature.nvim",
  config = function()
    require("lsp_signature").setup()
  end,
})

-- Rust enhanced LSP support
use({
  "simrat39/rust-tools.nvim",
  requires = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
})

-- Utilities to improve the TypeScript development experience for Neovim's built-in LSP client
use({
  "jose-elias-alvarez/nvim-lsp-ts-utils",
  requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim", "jose-elias-alvarez/null-ls.nvim" },
})

-- Inject LSP diagnostics, code actions, and more via Lua
use({
  "jose-elias-alvarez/null-ls.nvim",
  requires = "nvim-lua/plenary.nvim",
})

-- Completion
use("hrsh7th/nvim-cmp")
use("hrsh7th/cmp-buffer")
use("hrsh7th/cmp-calc")
use("hrsh7th/cmp-nvim-lsp")
use("hrsh7th/cmp-nvim-lua")
use("hrsh7th/cmp-path")
use("hrsh7th/cmp-vsnip")
use("andersevenrud/cmp-tmux")
-- Better sort for completion items that start with one or more underscores
use("lukas-reineke/cmp-under-comparator")

-- Improved quickfix window
use({
  "kevinhwang91/nvim-bqf",
  config = function()
    require("bqf").setup()
  end,
})

-- Displays a popup with possible key bindings of the command you started typing
use("folke/which-key.nvim")

-- Treesitter
use({
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
})
use({
  "nvim-treesitter/playground",
  requires = "nvim-treesitter/nvim-treesitter",
})
use({
  "nvim-treesitter/nvim-treesitter-textobjects",
  requires = "nvim-treesitter/nvim-treesitter",
})

-- Fuzzy finder
use({
  "nvim-telescope/telescope.nvim",
  requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
})
use "natecraddock/telescope-zf-native.nvim"

-- Snippets
use("rafamadriz/friendly-snippets")
use("hrsh7th/vim-vsnip")
use("hrsh7th/vim-vsnip-integ")

-- Autopairs
use("steelsojka/pears.nvim")
use({
  "RRethy/nvim-treesitter-endwise",
  requires = "nvim-treesitter/nvim-treesitter",
})

-- Tmux
use("christoomey/vim-tmux-navigator")
use({ "tmux-plugins/vim-tmux", ft = "tmux" })

-- Status line
use("hoob3rt/lualine.nvim")

-- Git
use("tpope/vim-git")
use("tpope/vim-fugitive")
use("rhysd/committia.vim")
use({
  "lewis6991/gitsigns.nvim",
  requires = "nvim-lua/plenary.nvim",
})

-- Color themes
use("folke/tokyonight.nvim")
use("rebelot/kanagawa.nvim")

-- File manager
use({
  "kyazdani42/nvim-tree.lua",
  requires = "kyazdani42/nvim-web-devicons",
})

-- Expand abbreviations for HTML like 'div>p#foo$*3>a' with '<c-y>,'
use("mattn/emmet-vim")

-- Changes the working directory to the project root when you open a file.
use("airblade/vim-rooter")

-- Automatically toggle relative line numbers based on mode.
use("ericbn/vim-relativize")

-- Comment code with gc{motion}, gcc, etc.
use("numToStr/Comment.nvim")

-- Highlight and search for todo comments like TODO, HACK, BUG
use({
  "folke/todo-comments.nvim",
  requires = "nvim-lua/plenary.nvim",
  config = function()
    require("todo-comments").setup()
  end,
})

-- Sets the commentstring option based on the cursor location in the file via treesitter queries.
-- Useful when there are embedded languages in certain types of files.
use("JoosepAlviste/nvim-ts-context-commentstring")

-- Automatically adjust shiftwidth and expandtab based on the current file
use("tpope/vim-sleuth")

-- Easily add/delete/change 'surroundings': parentheses, brackets, quotes, XML
-- tags, etc. [cs, ds, ys, yss]
use("tpope/vim-surround")
use("tpope/vim-repeat") -- Make repeat with `.` command work for vim-surround

-- ]q for :cnext. [q for :cprevious. ]a for :next. [b for :bprevious, etc.
use("tpope/vim-unimpaired")

-- Add emacs key bindings to vim in insert and command-line modes.
use("maxbrunsfeld/vim-emacs-bindings")

-- Help manage crates.io versions
use({ "Saecki/crates.nvim", requires = { "nvim-lua/plenary.nvim" } })

-- Vim sugar for the UNIX shell commands that need it the most (:Delete,
-- :Rename, :Mkdir, etc.)
use("tpope/vim-eunuch")

-- Quickly switch between Angular files
use("softoika/ngswitcher.vim")

-- Highlight hex and RGB colors in code
use("norcalli/nvim-colorizer.lua")

-- Icons to use in the status bar
use("ryanoasis/vim-devicons")

-- Adds more text objects to operate on like (), {}, [], <>, and t for tags.
use("wellle/targets.vim")

-- Close buffers without closing windows and messing up the layout.
use("moll/vim-bbye")

-- Add :DeleteHiddenBuffers to remove background buffers
use("arithran/vim-delete-hidden-buffers")

-- Internal modeline support allows all sorts of annoying and potentially insecure options to be set.
-- This plugin implements a more heavily restricted version.
use("ciaranm/securemodelines")

-- Adds indentation guides to all lines (including empty lines).
use({
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("indent_blankline").setup({
      char = "│",
      use_treesitter = true,
      show_first_indent_level = true,
      show_current_context = false,
      show_trailing_blankline_indent = false,
      filetype_exclude = { "help", "packer" },
      buftype_exclude = { "help", "terminal", "nofile" },
    })

    vim.g.indent_blankline_enabled = false
  end,
})

-- Sessions
use({
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({})
  end,
})
use({
  "rmagatti/session-lens",
  requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
  config = function()
    require("session-lens").setup({})
  end,
})

-- Remote clipboard
-- No need to use `lemonade`. This will allow copying to clipboard over SSH.
use({
  "ojroques/vim-oscyank",
  config = function()
    vim.cmd(
      [[autocmd TextYankPost * if v:event.operator is 'y' && (v:event.regname is '' || v:event.regname is '+') | execute 'OSCYankReg "' | endif"]]
    )
    vim.g.oscyank_silent = true
  end,
})

-- DAP (Debug Adapter Protocol)
use("mfussenegger/nvim-dap")
use("nvim-telescope/telescope-dap.nvim")
use("theHamsta/nvim-dap-virtual-text")
use("rcarriga/nvim-dap-ui")
use("Pocco81/DAPInstall.nvim")

-- Testing
use({
  "rcarriga/vim-ultest",
  requires = { "vim-test/vim-test" },
  run = ":UpdateRemotePlugins",
})

-- Language plugins
use("jparise/vim-graphql")
use("cespare/vim-toml")
use("kchmck/vim-coffee-script")
use("mustache/vim-mustache-handlebars")
use("tpope/vim-rails")
use("fladson/vim-kitty") -- kitty.conf

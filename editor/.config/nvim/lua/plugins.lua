-- On a new machine packer can be installed with the following commented code.
-- local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
--   vim.api.nvim_command 'packadd packer.nvim'
-- end

return require('packer').startup(function(use)
  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  -- use 'glepnir/lspsaga.nvim'
  use {'jasonrhansen/lspsaga.nvim', branch = 'finder-preview-fixes'}
  use 'onsails/lspkind-nvim'
  use 'folke/trouble.nvim'

  -- Location and syntax aware text objects which *do what you mean*
  use 'RRethy/nvim-treesitter-textsubjects'

  -- Improved quickfix window
  use 'kevinhwang91/nvim-bqf'

  -- Displays a popup with possible key bindings of the command you started typing
  use 'folke/which-key.nvim'

  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-treesitter/playground', requires = 'nvim-treesitter/nvim-treesitter'}

  -- Fuzzy finder
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Snippets
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- Autopairs
  use 'steelsojka/pears.nvim'
  use 'tpope/vim-endwise'

  -- Tmux
  use 'christoomey/vim-tmux-navigator'
  use 'edkolev/tmuxline.vim'
  use {'tmux-plugins/vim-tmux', ft = 'tmux'}

  -- Status line
  use 'hoob3rt/lualine.nvim'

  -- Git
  use 'tpope/vim-git'
  use 'tpope/vim-fugitive'
  use 'rhysd/committia.vim'
  use 'lewis6991/gitsigns.nvim'
  use 'sindrets/diffview.nvim' -- Open with :DiffviewOpen

  -- Color themes
  use 'nanotech/jellybeans.vim'
  use 'glepnir/zephyr-nvim'
  use {'briones-gabriel/darcula-solid.nvim', requires = 'rktjmp/lush.nvim'}
  use 'shaunsingh/solarized.nvim'
  use 'folke/tokyonight.nvim'

  -- File manager
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  use 'kyazdani42/nvim-tree.lua'

  -- Expand abbreviations for HTML like 'div>p#foo$*3>a' with '<c-y>,'
  use 'mattn/emmet-vim'

  -- Changes the working directory to the project root when you open a file.
  use 'airblade/vim-rooter'

  -- Automatically toggle relative line numbers based on mode.
  use 'kennykaye/vim-relativity'

  -- Comment code with gc{motion}, gcc, etc.
  use 'tomtom/tcomment_vim'

  --" Hex editor
  use 'Shougo/vinarise.vim'

  -- Automatically adjust shiftwidth and expandtab based on the current file
  use 'tpope/vim-sleuth'

  -- Easily add/delete/change 'surroundings': parentheses, brackets, quotes, XML
  -- tags, etc. [cs, ds, ys, yss]
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat' -- Make repeat with `.` command work for vim-surround

  -- ]q for :cnext. [q for :cprevious. ]a for :next. [b for :bprevious, etc.
  use 'tpope/vim-unimpaired'

  -- Add emacs key bindings to vim in insert and command-line modes.
  use 'maxbrunsfeld/vim-emacs-bindings'

  -- Show outdated crates in Cargo.toml
  use 'mhinz/vim-crates'

  -- Vim sugar for the UNIX shell commands that need it the most (:Delete,
  -- :Rename, :Mkdir, etc.)
  use 'tpope/vim-eunuch'

  -- Quickly switch between Angular files
  use 'softoika/ngswitcher.vim'

  -- Highlight hex and RGB colors in code
  use 'norcalli/nvim-colorizer.lua'

  -- Icons to use in the status bar
  use 'ryanoasis/vim-devicons'

  -- Defines motions ',w', ',b' and ',e' (similar to 'w', 'b', 'e'),
  -- which do not move word-wise (forward/backward), but Camel-wise
  use 'vim-scripts/camelcasemotion'

  -- Adds more text objects to operate on like (), {}, [], <>, and t for tags.
  use 'wellle/targets.vim'

  -- Briefly highlight yanked text
  use 'machakann/vim-highlightedyank'

  -- Close buffers without closing windows and messing up the layout.
  use 'moll/vim-bbye'

  -- Adds the following:
  -- gS to split a one-liner into multiple lines
  -- gJ (with the cursor on the first line of a block) to join a block into a single-line statement
  use 'AndrewRadev/splitjoin.vim'

  -- Add :DeleteHiddenBuffers to remove background buffers
  use 'arithran/vim-delete-hidden-buffers'

  -- Run prettier with :Prettier, :PrettierAsync, :PrettierPartial, :PrettierFragment, etc.
  use {'prettier/vim-prettier', run = 'yarn install'}

  -- Internal modeline support allows all sorts of annoying and potentially insecure options to be set.
  -- This plugin implements a more heavily restricted version.
  use 'ciaranm/securemodelines'

  -- Language plugins
  use 'jparise/vim-graphql'
  use 'cespare/vim-toml'
  use 'kchmck/vim-coffee-script'
  use 'mustache/vim-mustache-handlebars'
  use 'tpope/vim-rails'
  use 'fladson/vim-kitty' -- kitty.conf
end)

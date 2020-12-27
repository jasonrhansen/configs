-- Install packer.nvim if not already installed.
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}

  use {'neovim/nvim-lspconfig', cond = Use_nvim_lsp}
  use {'nvim-lua/completion-nvim', cond = Use_nvim_lsp}
  use {'nvim-lua/lsp-status.nvim', cond = Use_nvim_lsp}
  use {'nvim-treesitter/nvim-treesitter', cond = Use_nvim_lsp}
  use {'nvim-treesitter/playground', cond = Use_nvim_lsp}
  -- use 'nvim-treesitter/nvim-treesitter-textobjects'

  use {
    'neoclide/coc.nvim',
    branch = 'release',
    cond = function()
      return not Use_nvim_lsp()
    end
  }

  -- Alternative to vim-gitgutter
  use 'mhinz/vim-signify'

  -- Instead of coc-prettier
  use {'prettier/vim-prettier', run = 'yarn install'}

  use 'SirVer/ultisnips'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
  }
  use {
    'nvim-telescope/telescope-fzy-native.nvim',
    requires = 'nvim-telescope/telescope.nvim'
  }

  use 'kana/vim-altercmd'
  use 'ciaranm/securemodelines'
  use 'itchyny/lightline.vim'
  use 'machakann/vim-highlightedyank'
  use 'airblade/vim-rooter'
  -- Snippets used by snippets engine
  use 'honza/vim-snippets'
  use 'christoomey/vim-tmux-navigator'
  use 'tmux-plugins/vim-tmux-focus-events'
  use 'edkolev/tmuxline.vim'
  use 'kennykaye/vim-relativity'
  use 'tomtom/tcomment_vim'
  use 'vhdirk/vim-cmake'
  -- Automatically adjust shiftwidth and expandtab based on the current file
  use 'tpope/vim-sleuth'
  -- Hex editor
  use 'Shougo/vinarise.vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar'
  use 'vim-scripts/camelcasemotion'
  use 'wellle/targets.vim'
  -- Use this version instead of vim-scripts/a.vim because it
  -- won't create imaps by default.
  use 'fanchangyong/a.vim'

  use {'mbbill/undotree', cmd = 'UndotreeToggle'}

  use 'moll/vim-bbye'
  use 'ntpeters/vim-better-whitespace'
  use 'AndrewRadev/splitjoin.vim'
  -- Add emacs key bindings to vim in insert and command-line modes.
  use 'maxbrunsfeld/vim-emacs-bindings'
  -- Show outdated crates in Cargo.toml
  use 'mhinz/vim-crates'
  use {'chrisbra/csv.vim', ft = 'csv'}
  use 'tpope/vim-git'
  use 'jparise/vim-graphql'
  use {'groenewege/vim-less', ft = 'Less'}
  use 'wlangstroth/vim-racket'
  use {'toyamarinyon/vim-swift', ft = 'swift'}
  use {'tmux-plugins/vim-tmux', ft = 'tmux'}
  use 'cespare/vim-toml'
  -- Git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'rhysd/committia.vim'
  use 'kchmck/vim-coffee-script'
  use 'mustache/vim-mustache-handlebars'
  use 'arithran/vim-delete-hidden-buffers'
  use 'tpope/vim-rails'
  -- Vim sugar for the UNIX shell commands that need it the most (:Delete,
  -- :Rename, :Mkdir, etc.)
  use 'tpope/vim-eunuch'
  use 'norcalli/nvim-colorizer.lua'
  use 'ryanoasis/vim-devicons'

  -- Expand abbreviations for HTML like 'div>p#foo$*3>a' with '<c-y>,'
  use 'mattn/emmet-vim'

  -- Color theme
  use 'nanotech/jellybeans.vim'

  -- File manager
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  -- Fork of 'kyazdani42/nvim-tree.lua' that doesn't disable netrw.
  use 'jasonrhansen/nvim-tree.lua'

  -- Quickly switch between Angular files
  use 'softoika/ngswitcher.vim'

  -- Simple plugins can be specified as strings
  use '9mm/vim-closer'
end)

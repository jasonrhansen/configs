lua require('plugins')

" Reset the vimrc augroup. Autocommands are added to this group throughout.
augroup vimrc
  autocmd!
augroup END

syntax on
filetype plugin on
filetype indent on
let mapleader="\<SPACE>"
let maplocalleader="-"
let &showbreak = '↳ '

syntax sync minlines=256          " Increase scrolling performance

augroup vimrc
  " Allow .md extension to be recognized as markdown
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Start git commits in insert mode
  autocmd FileType gitcommit startinsert
  autocmd FileType gitcommit set colorcolumn=80

  " Automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  " Briefly highlight yanked text
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300}
augroup END

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif


let g:tokyonight_style = "night"
let g:tokyonight_colors = { 'border': '#292E42' }
" colorscheme tokyonight

lua << EOF
local colors = require("kanagawa.colors").setup()
require("kanagawa").setup({
  overrides = {
    VertSplit = { fg = colors.sumiInk4, bg = colors.bg },
  }
})
EOF
colorscheme kanagawa

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the 'standard' one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as
  " '*'.
  " See :h 'clipboard' for details.
  set clipboard=unnamedplus,unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif

" Automatically set tmux window name
if exists('$TMUX') && !exists('$NORENAME')
  augroup vimrc
    autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  augroup END
endif

let g:python_host_prog = trim(system('which python2'))
let g:python3_host_prog = trim(system('which python3'))


command! BufOnly execute '%bdelete|edit #|normal `"'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Plugin Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup vimrc
  " Automatically delete hidden fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" Detect binary file or large file automatically
let g:vinarise_enable_auto_detect = 1

" Use new, faster filetype detection introduced in neovim 0.7
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

lua << EOF

local lua_modules = {
  "config.options",
  "config.lsp",
  "config.telescope",
  "config.nvim_cmp",
  "config.window_picker",
  "config.neo_tree",
  "config.gitsigns",
  "config.treesitter",
  "config.pears",
  "config.trouble",
  "config.which_key",
  "config.keymaps",
  "config.lualine",
  "config.rust_tools",
  "config.crates",
  "config.dap",
  "config.comment",
  "config.luasnip",
  "config.nvim_retrail",
  "config.winbar",
}

for _, module_name in ipairs(lua_modules) do
  -- Remove cached module so config can be reloaded without restarting neovim
  package.loaded[module_name] = nil

  require(module_name)
end

EOF

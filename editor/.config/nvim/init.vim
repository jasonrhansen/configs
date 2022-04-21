lua require('plugins')

" Reset the vimrc augroup. Autocommands are added to this group throughout.
augroup vimrc
  autocmd!
augroup END

set nocompatible                  " be iMproved
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Custom Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn off search highlights by pressing return unless in quickfix window
nnoremap <expr> <cr> &buftype ==# 'quickfix' ? "\<CR>" : ':noh<cr>'

" Escape is too much of a reach. Use jk to exit insert mode and command mode.
inoremap jk <esc>
cnoremap jk <c-e><c-u><esc>

" Add a 'stamp' command to replace word or selection with yanked text.
nnoremap <leader>p "_diwP
vnoremap <leader>p "_dP

" Make 'Y' work from the cursor to end of line instead of like 'yy'
nnoremap Y y$

" Reselect visual selection after indent
xnoremap < <gv
xnoremap > >gv

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Also center the screen when jumping through the changelist
nnoremap g; g;zz
nnoremap g, g,z

" With this map, we can select some text in visual mode and by invoking the map,
" have the selection automatically filled in as the search text and the cursor
" placed in the position for typing the replacement text. Also, this will ask
" for confirmation before it replaces any instance of the search text in the
" file.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" This makes j and k work on "screen lines" instead of on "file lines"; now, when
" we have a long line that wraps to multiple screen lines, j and k behave as we
" expect them to.
nnoremap j gj
nnoremap k gk

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" Don't move cursor when joining lines
nnoremap J mzJ`z

" Add undo break points for punctuation
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Move lines up and down
inoremap <m-k> <esc>:m .-2<cr>==
inoremap <m-j> <esc>:m .+1<cr>==
nnoremap <m-k> :m .-2<cr>==
nnoremap <m-j> :m .+1<cr>==
vnoremap <m-k> :m '<-2<cr>gv=gv
vnoremap <m-j> :m '>+1<cr>gv=gv

" Resize windows with the arrow keys and shift key
nnoremap <s-up> 10<C-W>+
nnoremap <s-down> 10<C-W>-
nnoremap <s-left> 3<C-W><
nnoremap <s-right> 3<C-W>>

" Exit insert mode and save just by hitting CTRL-s
imap <c-s> <esc>:w<cr>
nmap <c-s> <esc>:w<cr>

" I never use command line window on purpose
nnoremap q: :

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

" Expand or jump
imap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-j>'
snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(1)<Cr>

" Jump backward
inoremap <silent> <C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes.
imap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

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

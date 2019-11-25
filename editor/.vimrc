""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/bundle')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ciaranm/securemodelines'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-rooter'

Plug 'PeterRincker/vim-argumentative'
" Snippets used by snippets engine
Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'edkolev/tmuxline.vim'
Plug 'majutsushi/tagbar'
Plug 'kennykaye/vim-relativity'
Plug 'tomtom/tcomment_vim'
Plug 'vhdirk/vim-cmake'
" Automatically adjust shiftwidth and expandtab based on the current file
Plug 'tpope/vim-sleuth'
"" Hex editor
Plug 'Shougo/vinarise.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/camelcasemotion'
Plug 'wellle/targets.vim'
" Use this version instead of vim-scripts/a.vim because it
" won't create imaps by default.
Plug 'fanchangyong/a.vim'
Plug 'chriskempson/base16-vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Skim is a fuzzy finder written in Rust that's similar to fzf.
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'AndrewRadev/splitjoin.vim'

" Add emacs key bindings to vim in insert and command-line modes.
Plug 'maxbrunsfeld/vim-emacs-bindings'

" C/C++/ObjC
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp', 'objc'] }
Plug 'vim-jp/cpp-vim', { 'for': ['c', 'cpp', 'objc'] }
" CSV
Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" Git
Plug 'tpope/vim-git'
" Go
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'rhysd/vim-go-impl', { 'for': 'go' }
" GraphQL
Plug 'jparise/vim-graphql'
" Haskell
Plug 'lukerandall/haskellmode-vim'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" HTML/CSS/SCSS
Plug 'JulesWang/css.vim', { 'for': ['css', 'html', 'html5', 'less'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'html', 'html5', 'less', 'scss'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'html', 'html5', 'less'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }
Plug 'othree/html5.vim', { 'for': ['css', 'html', 'html5'] }
" Javascript/CoffeeScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'matthewsimo/angular-vim-snippets'
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
Plug 'kchmck/vim-coffee-script'
" JSON
Plug 'leshill/vim-json'
" Less
Plug 'groenewege/vim-less', { 'for': 'Less' }
" Markdown
Plug 'plasticboy/vim-markdown'
" Python
Plug 'davidhalter/jedi-vim'           " Python autocompletion
" Ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-bundler'
" Rust
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-crates'
" Scheme - Racket dialect
Plug 'wlangstroth/vim-racket'
" Swift
Plug 'toyamarinyon/vim-swift', { 'for': 'swift' }
" Tmux syntax
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
" Typescript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" Vimscript
Plug '~/dev/projects/api-soup', {'rtp': 'vim-syntax/'}
" TOML
Plug 'cespare/vim-toml'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Reset vimrc augroup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reset the vimrc augroup. Autocommands are added to this group throughout.
augroup vimrc
    autocmd!
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved
syntax on
filetype plugin on
filetype indent on
let mapleader="\<SPACE>"
let maplocalleader="-"

set hidden
set wildmenu
set wildmode=list:full
set wildignorecase
set showfulltag
set history=1000
set ignorecase
set smartcase
set title
set scrolloff=3
set ruler
set backspace=indent,eol,start
set incsearch
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set wildchar=<Tab>
set foldmethod=marker
set textwidth=0
set undolevels=1000
set showcmd
set showmatch
set number
set cursorline
set synmaxcol=1000
" Update syntax highlighting for more lines increased scrolling performance
syntax sync minlines=256
set autoread
set cpoptions+=$
set background=dark
" Remove menu bar
set guioptions-=m
" Remove toolbar
set guioptions-=T
let &showbreak = '↳ '
set breakindent
set breakindentopt=sbr
set listchars=tab:\ \ ,trail:▫      " Characters to use for whitespace when set list
set linebreak                       " Break properly, don't split words
set scrolloff=4                     " Show context above/below cursorline
set formatoptions+=j
set sidescrolloff=5
set shiftround
set nostartofline
set laststatus=2
set noerrorbells
set visualbell
set secure
set nomodeline                      " Use securemodelines instead

" Session and view options to save
set sessionoptions=buffers,folds,tabpages,curdir,globals
set viewoptions=cursor,folds

" This feels more natural
set splitbelow
set splitright

set undofile
set nobackup
set nowritebackup
set noswapfile

set undodir=~/.vim/tmp/undo//           " undo files

set mouse=a                             " Enable mouse in all modes
set mousemodel=popup_setpos             " Right-click on selection should bring up a menu
if !has('nvim')
  set ttymouse=xterm2                   " Needed to be able to resize panes with mouse
endif

set pastetoggle=<F2>

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

augroup vimrc
    " Automatically rebalance windows on vim resize
    autocmd VimResized * :wincmd =
augroup END

" Color scheme preferences
if (exists('$TMUX') && system('tmux show-env TERMINAL_THEME') == "TERMINAL_THEME=light\n") || $TERMINAL_THEME == "light"
    set background=light
else
    set background=dark
endif
let base16colorspace=256
colorscheme base16-atelier-dune

" Cursor configuration
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
let &t_SI                         = "\<Esc>[5 q"
let &t_SR                         = "\<Esc>[3 q"
let &t_EI                         = "\<Esc>[2 q"

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

if !has('nvim')
    set encoding=utf-8
endif

" Don't use clipboard over ssh since it makes vim load too slowly.
if !has("gui_running") && !has("nvim")
    let g:display_num =
                \ substitute(
                \ substitute( $DISPLAY , "^[[:alpha:]]*:" , "" , "" ) ,
                \ "\.[[:digit:]]*$" , "" , "" )
    if ( g:display_num >= 10 )
        set clipboard=exclude:.*
    endif
endif

" Automatically set tmux window name
if exists('$TMUX') && !exists('$NORENAME')
  augroup vimrc
    autocmd BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    autocmd VimLeave * call system('tmux set-window automatic-rename on')
  augroup END
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 Custom Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easily grep for word or WORD under cursor
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cword>")) . " ."<cr>:cw<cr>
nnoremap <leader>G :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:cw<cr>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Turn of search highlights by pressing return unless in quickfix window
nnoremap <expr> <cr> &buftype ==# 'quickfix' ? "\<CR>" : ':noh<cr>'

" Use backspace to toggle between current file and previous file
nnoremap <bs> <c-^>

" Escape is too much of a reach. Use jk to exit insert mode and command mode.
inoremap jk <esc>
cnoremap jk <c-e><c-u><esc>
" Also c-k also works well for this
inoremap <c-k> <esc>
cnoremap <c-k> <c-e><c-u><esc>

" Make editing and sourcing .vimrc really easy.
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Add a 'stamp' command to replace word or selection with yanked text.
nnoremap S diw"0P
vnoremap S "_d"0P

" Make "Y" work from the cursor to end of line instead of like "yy"
nnoremap Y y$

" Fast saving
nnoremap <leader>w :w!<cr>

" Reselect visual selection after indent
xnoremap < <gv
xnoremap > >gv

" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
cnoremap w!! w !sudo tee % >/dev/null

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Keep search matches in the middle of the window.
" zz centers the screen on the cursor, zv unfolds any fold if the cursor
" suddenly appears inside a fold.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv<silent> zk O<Esc>j

" Also center the screen when jumping through the changelist
nnoremap g; g;zz
nnoremap g, g,z

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

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

" Move between buffers faster
nnoremap <silent> <C-b> :silent :bp<CR>
nnoremap <silent> <C-n> :silent :bn<CR>

" Switch between source and header files with a.vim
nmap <leader>h :A<cr>

if has('nvim')
    " Make working with nvim terminal emulator nicer
    tnoremap <esc> <c-\><c-n>
    tnoremap jk    <c-\><c-n>
    tnoremap <c-h> <c-\><c-n><c-w>h
    tnoremap <c-j> <c-\><c-n><c-w>j
    tnoremap <c-k> <c-\><c-n><c-w>k
    tnoremap <c-l> <c-\><c-n><c-w>l
    augroup vimrc
        " Don't show line numbers in terminal
        autocmd BufWinEnter,WinEnter term://* set nonumber
        " Always put terminal in insert mode on enter
        autocmd BufWinEnter,WinEnter term://* startinsert
    augroup END

    " Don't let relativity handle line numbers in terminal
    let g:relativity_buftype_ignore = ['nofile', 'terminal']

    set inccommand=nosplit
endif

" Toggle between light and dark version of theme
noremap <F6> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

augroup vimrc
    " Reload vimrc after saving
    autocmd BufWritePost $MYVIMRC,.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc,init.vim source %
augroup END

augroup ruby_group
    autocmd!
    autocmd FileType ruby,eruby nmap gd g<C-]>
	autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
    autocmd filetype ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd filetype ruby,eruby let g:rubycomplete_rails = 1
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                Plugin Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim
let g:used_javascript_libs='jquery,angularjs'

" Automatically format C++ code on save
let g:clang_format#auto_format = 1

augroup vimrc
    " Allow .md extension to be recognized as markdown
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

" For haskell documentation
let g:haddock_browser="/usr/bin/google-chrome-beta"

" Haskell compiler plugin
augroup vimrc
    autocmd BufEnter *.hs compiler ghc
augroup END

augroup vimrc
    " Start git commits in insert mode
    autocmd FileType gitcommit startinsert
    autocmd FileType gitcommit set colorcolumn=80
augroup END

nnoremap <Leader>q :Bdelete<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <silent> <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = [
            \ 'coc-angular',
            \ 'coc-css',
            \ 'coc-eslint',
            \ 'coc-git',
            \ 'coc-highlight',
            \ 'coc-html',
            \ 'coc-java',
            \ 'coc-json',
            \ 'coc-markdownlint',
            \ 'coc-pairs',
            \ 'coc-phpls',
            \ 'coc-prettier',
            \ 'coc-python',
            \ 'coc-rust-analyzer',
            \ 'coc-snippets',
            \ 'coc-solargraph',
            \ 'coc-svg',
            \ 'coc-tsserver',
            \ 'coc-vimlsp',
            \ 'coc-xml',
            \ 'coc-yaml',
            \ ]

" coc extension settings

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

autocmd FileType rust let b:coc_pairs_disabled = ['''']
autocmd FileType markdown let b:coc_pairs_disabled = ['`']
autocmd FileType vim let b:coc_pairs_disabled = ['"']

" Make coc-pairs work well with <cr>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    skim/fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" skim.vim is a fork of fzf.vim and is configured the same way
" except that it uses sk instead of fzf.

nnoremap [fzf] <nop>
" fzf prefix key
nmap t [fzf]

if executable('ag')
    nnoremap [fzf]a :Ag<cr>
endif

nnoremap [fzf]b :Buffers<cr>
nnoremap [fzf]c :Commands<cr>
nnoremap [fzf]l :BLines<cr>
nnoremap [fzf]L :Lines<cr>
nnoremap [fzf]m :Marks<cr>
nnoremap [fzf]p :Files<cr>
nnoremap [fzf]P :GFiles<cr>
nnoremap [fzf]s :Snippets<cr>
nnoremap [fzf]t :BTags<cr>
nnoremap [fzf]T :Tags<cr>
nnoremap [fzf]g :BCommits<cr>
nnoremap [fzf]G :Commits<cr>
nnoremap [fzf]h :History<cr>
nnoremap [fzf]/ :History/<cr>
nnoremap [fzf]: :History:<cr>
nnoremap [fzf]H :Helptags<cr>
nnoremap [fzf]M :Maps<cr>

imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

augroup vimrc
    " Close fzf buffer with ESC
    autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
    " Close skim buffer with ESC
    autocmd! FileType skim tnoremap <buffer> <esc> <c-c>
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Lightline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

let g:lightline = {}

let g:lightline.component_function = {
      \ 'filename': 'LightlineFilename',
      \ 'gitbranch': 'fugitive#head',
      \ 'cocstatus': 'coc#status',
      \ 'currentfunction': 'CocCurrentFunction'
      \ }

let g:lightline.active = {
      \ 'left': [['mode', 'paste'], ['readonly', 'filename', 'modified'], ['gitbranch']],
      \ 'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype'], ['cocstatus', 'currentfunction']]
      \ }

let g:lightline.inactive = {
      \ 'left': [['filename']],
      \ 'right': [['lineinfo'], ['percent']]
      \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     Tabular
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Looks at the current line and the lines above and below it and aligns all the
" equals signs. Useful for when we have several lines of declarations.
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a/ :Tabularize /\/\//l2c1l0<CR>
vnoremap <Leader>a/ :Tabularize /\/\//l2c1l0<CR>
nnoremap <Leader>a, :Tabularize /,/l0r1<CR>
vnoremap <Leader>a, :Tabularize /,/l0r1<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                    UltiSnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetsDir   = $HOME . '/dotfiles/vim/UltiSnips'
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:snips_author           = 'Jason Rodney Hansen'
augroup UltiSnips_group
    autocmd!
    " UltiSnips is missing a setf trigger for snippets on BufEnter
    autocmd vimrc BufEnter *.snippets setf snippets
    " In UltiSnips snippet files, we want actual tabs instead of spaces for
    " indents. US will use those tabs and convert them to spaces if expandtab
    " is set when the user wants to insert the snippet.
    autocmd vimrc FileType snippets set noexpandtab
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             vim-better-whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>t  :StripWhitespace<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 vim-crates
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
  autocmd BufRead Cargo.toml call crates#toggle()
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup go_group
    autocmd!
    autocmd FileType go nmap <Leader>i <Plug>(go-import)

    autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)
    autocmd FileType go nmap <leader>gr <Plug>(go-run)
    autocmd FileType go nmap <leader>gb <Plug>(go-build)
    autocmd FileType go nmap <leader>gt <Plug>(go-test)
    autocmd FileType go nmap <leader>gc <Plug>(go-coverage)

    autocmd FileType go nmap <leader>r <Plug>(go-rename)
    autocmd FileType go nmap <leader>n <Plug>(go-callees)

    autocmd FileType go nmap gd <Plug>(go-def)
    autocmd FileType go nmap <K> <Plug>(go-doc)

    autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
    autocmd FileType go nmap <Leader>dv <Plug>(go-def-vertical)
    autocmd FileType go nmap <Leader>dt <Plug>(go-def-tab)
augroup END

let g:go_fmt_command = 'goimports'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_addtags_transform = "snakecase"

" Tagbar for Go. Requires gotags.
" go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   vinarise
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Detect binary file or large file automatically
let g:vinarise_enable_auto_detect = 1


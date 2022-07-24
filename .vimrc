" hAx0r vimrc, bite the dust
" lots borrowed from Seth House :P

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plugin 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plugin 'scrooloose/syntastic'
Plugin 'tmhedberg/matchit'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'moll/vim-node'
Plugin 'elzr/vim-json'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'petrbroz/vim-glsl'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-surround'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'bkad/camelcasemotion'
call vundle#end()            " required

let g:coc_node_path = "/opt/homebrew/bin/node"
let gruby_recommended_style = 1

"colorscheme desert
colorscheme molokai
if &diff
    colorscheme molokai
endif

autocmd VimEnter * :hi IncSearch cterm=NONE ctermfg=black ctermbg=green
autocmd VimEnter * :hi Search cterm=NONE ctermfg=black ctermbg=blue
"autocmd VimEnter * :hi Visual cterm=reverse,bold
autocmd VimEnter * :hi Visual cterm=NONE ctermbg=grey ctermfg=black
autocmd VimEnter * :hi LineNr ctermfg=grey

let mapleader=","
set nocompatible     " cp: turn off vi compatibility
set autochdir

" Search {{{

set incsearch   "is:    automatically begins searching as you type
set ignorecase  "ic:    ignores case when pattern matching
set smartcase   "scs:   ignores ignorecase when pattern contains uppercase
set hlsearch    "hls:   highlights search results
set wrapscan    "ws: wrap around the file when searching

" Use ,<space> to unhighlight search results in normal mode:
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" }}}
" Line Wrap {{{
set backspace=indent,eol,start "bs: backspace over these chars
set linebreak                  "lbr: don't wrap text in the middle of a word
set nowrap                     "wrap: don't wrap lines

" }}}
" Editing {{{

syntax on       "syn:   syntax highlighting
set showmatch   "sm:    flashes matching brackets or parentheses
set number

set nobackup    "bk:    don't pollute my fs
set nowritebackup "wb:  don't pollute my fs
set noswapfile  "swf:   don't pollute my fs with swp files

" Searches the current directory as well as subdirectories with commands like
" :find, :grep, etc.
set path=.,**
set grepprg=a

set tabstop=2     "ts:    number of spaces that a tab counts for
set softtabstop=2 "sts:   number of spaces that a tab counts for when editing
set expandtab     "et:    uses spaces instead of tab characters
set smarttab      "sta:   helps with backspacing because of expandtab
set shiftwidth=2  "sw:    number of spaces to use for autoindent
set shiftround    "sr:    rounds indent to a multiple of shiftwidth
set autoindent    "ai:    copy indent from current line
"set textwidth=100 "tw:    text width of text in columns

set nojoinspaces "nojs: no inserting two spaces after punctuation on a join
set lazyredraw   "lz:    will not redraw the screen while running macros
"set pastetoggle=<leader>p "pt: key binding for paste/nopaste
map <silent> <leader>p :set paste!<CR>:set paste?<CR>i

"nnoremap <C-F> <esc>
"vnoremap <C-F> <esc>gV
"onoremap <C-F> <esc>
"inoremap <C-F> <esc>`^

" Fix for legacy vi inconsistency
map Y y$

"lcs:   displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>,nbsp:.
set nolist

" completion
set infercase

" }}}
" Folding (spacebar toggles) {{{
" Spacebar toggles a fold, zi toggles all folding, zM closes all folds
noremap  <silent>  <space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>

"set foldmethod=marker "fdm:   looks for patterns of triple-braces in a file

" }}}
" Menu completion {{{

set wildmenu                    "wmnu:  enhanced ex command completion
set wildmode=longest:full,list:full  "wim:   helps wildmenu auto-completion

" }}}
" Window Layout {{{

set hidden
set showmode         "smd:   shows current vi mode in lower left
"set cursorline       "cul:   highlights the current line
set showcmd          "sc:    shows typed commands
set sidescroll=2     "ss:    scroll horizontally by 2
set scrolloff=1      "so:    one line before the screen edge when scrolling
set sidescrolloff=2  "siso:  2 cols between the current col and the edge
set laststatus=2     "ls:    makes the status bar always visible
set ttyfast          "tf:    improves redrawing for newer computers
set viminfo='100,f1,:100,/100   "vi:    For a nice, huuuuuge viminfo file
set ruler            "ru:    show line and column number
set bg=dark
set matchtime=2      "mat:   tenths of a second to show the matching paren
if &columns == 80
    " If we're on an 80-char wide term, don't display these screen hogs
    set nonumber
endif
" }}}
" Multi-buffer/window/tab editing {{{

set splitright "spr:   puts new vsplit windows to the right of the current
set splitbelow "sb:    puts new split windows to the bottom of the current

set winminheight=0 "wmh:   the minimal line height of any non-current window
set winminwidth=0  "wmw:   the minimal column width of any non-current window

" }}}
"set cursorline

"""""""""""""""""""""""""
let html_use_css=1

:filetype plugin on
:filetype plugin indent on

set uc=100
set ut=4000

set timeout timeoutlen=1000 ttimeoutlen=400
if !has("gui_running") && &term == "rxvt*"
    map <ESC>[18^ <C-F7>
    map <ESC>[19^ <C-F8>
    map <ESC>[20^ <C-F9>
    map <ESC>[23^ <C-F11>
    map <ESC>[24^ <C-F12>
    map <ESC>[23$ <S-F11>
    map! <ESC>[18^ <C-F7>
    map! <ESC>[19^ <C-F8>
    map! <ESC>[20^ <C-F9>
    map! <ESC>[23^ <C-F11>
    map! <ESC>[24^ <C-F12>
    map! <ESC>[23$ <S-F11>
endif

:map <silent> <C-l> :bn!<CR>
:map! <silent> <C-l> <ESC>:bn!<CR>

:map <silent> <C-k> <ESC>:bp!<CR>
:map! <silent> <C-k> :bp!<CR>

:map <F3> @w
:map! <F3> @w
:map <F4> @q
:map! <F4> @q

:map <F5> <ESC>:wa!<CR>
:map! <F5> <ESC>:wa!<CR>
:map <C-s> <ESC>:wa!<CR>
:map! <C-s> <ESC>:wa!<CR>

:map <F6> <ESC>:xa<CR>
:map! <F6> <ESC>:xa<CR>

":map! <F7> <ESC>:bd<CR>
":map! <F8> <ESC>:mks! session.vim<CR>
:map <F9> <ESC>:qa!<CR>
:map! <F9> <ESC>:qa!<CR>
:map <C-q> <ESC>:qa!<CR>
:map! <C-q> <ESC>:qa!<CR>

:map <C-w>x :bd<CR>:vsp<CR>:bn!<CR>
:map <C-w>z :bd<CR>:sp<CR>:bn!<CR>

:inoremap jj <ESC>
set timeoutlen=200

" Forgot to sudo
cmap w!! w !sudo tee % >/dev/null

:vnoremap < <gv
:vnoremap > >gv

" Don't move on *
nnoremap * *<c-o>

" Fuck you, man key.
nnoremap K <nop>

" Make operations work with the OS clipboard
"set clipboard=unnamed

" When pasting over selected text in visual mode, re-copy what you're pasting
" instead of trampling it with what you pasted over.
xnoremap <expr> p v:register=='"'?'pgvy':'p'

set undofile
set undodir=~/.vim-undo

"if filereadable(expand(expand("~/.vimrc.plugins")))
"  source ~/.vimrc.plugins
"endif

au BufRead *.mako set filetype=mako
au BufRead *.mkd set filetype=mkd
au BufRead *.md set filetype=mkd
au BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
au BufRead ChangeLog* set et tw=80
au BufRead *.vm set filetype=vm

au BufRead,BufNewFile *.rb set sw=2
au BufRead,BufNewFile *.vala set filetype=vala
au BufRead,BufNewFile *.vapi set filetype=vala
au BufRead,BufNewFile *.gradle setf groovy

if has("gui_running")
  " colorscheme fruity
  if has("gui_gtk2")
    set guifont=Terminus\ 9
  endif
else
  if &term != "linux"
    set t_Co=256
    set ttymouse=xterm2
    set mouse=a
    "autocmd VimEnter * :GuiColorScheme fruity
  endif
endif

if has("win32")
  set guifont=Consolas:h9:cDEFAULT
endif

if filereadable(expand(expand("~/.vimrc.local")))
  source ~/.vimrc.local
endif

set vb t_vb=

":imap <C-Space> <Plug>AutocomplpopOnPopupPost

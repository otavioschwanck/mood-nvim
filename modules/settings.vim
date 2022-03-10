au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
autocmd SwapExists * let v:swapchoice = "e"

set undofile

set nu

autocmd!
scriptencoding utf-8

" stop loading config if it's on tiny or small
if !1 | finish | endif

set hidden

set nocompatible
set ic
set colorcolumn=125
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set hlsearch
set showcmd
set cmdheight=2
set updatetime=200
set laststatus=2
set scrolloff=10
set expandtab
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*
set shortmess+=c
set timeoutlen=400

set nobackup
set nowritebackup

if has('nvim')
  set inccommand=split
endif

set t_BE=

set nosc noru nosm
set lazyredraw
set ignorecase
set smarttab
filetype plugin indent on
filetype plugin on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

""" Highlights
set cursorline

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" open new split panes to right and below
set splitright
set splitbelow
au BufEnter * :set signcolumn=yes

autocmd SwapExists * let v:swapchoice = "e"

let g:lightline = {'colorscheme': 'gruvbox-flat'}

let g:gruvbox_flat_style = "hard"

set background=dark
colorscheme gruvbox-flat

set confirm

set clipboard=unnamedplus

let g:camelsnek_i_am_an_old_fart_with_no_sense_of_humour_or_internet_culture = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb'

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_select_all_word_key = 'ga'
let g:multi_cursor_quit_key            = '<Esc>'

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

let g:gruvbox_flat_style = "hard"

set background=dark
set termguicolors
colorscheme gruvbox

set confirm

set clipboard=unnamed,unnamedplus

let g:camelsnek_i_am_an_old_fart_with_no_sense_of_humour_or_internet_culture = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb'

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_select_all_word_key = 'gq'
let g:multi_cursor_start_word_key      = '<A-d>'
let g:multi_cursor_next_key            = '<A-d>'
let g:multi_cursor_quit_key            = '<Esc>'

" Vim Script
let g:nvim_tree_respect_buf_cwd = 1

lua << EOF
require("nvim-tree").setup({
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})
EOF

function! <SID>StripTrailingWhitespaces()
  " save last search & cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

autocmd BufWritePre * call <SID>StripTrailingWhitespaces()

aug python
    au!
    autocmd BufWritePre *.py Black
aug END

augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

let g:yoinkSavePersistently = 1
let g:yoinkIncludeDeleteOperations = 1
let g:yoinkMaxItems = 20

let g:ruby_debugger = "byebug"

function AddDebugger()
  let buftype = getbufvar('', '&filetype', 'ERROR')

  if buftype == "ruby"
    execute "norm O" . g:ruby_debugger
  endif

  if buftype == "eruby"
    execute "norm O<% " . g:ruby_debugger . " %>"
  endif

  execute "stopinsert"
endfunction

function ClearDebugger()
  let buftype = getbufvar('', '&filetype', 'ERROR')

  if buftype == "ruby"
    execute "%s/.*" . g:ruby_debugger . "\\n//gr"
  endif

  if buftype == "eruby"
    execute "%s/.*<% " . g:ruby_debugger . " %>\\n//gr"
  endif
endfunction

function FindInFolder(folder, title)
  if isdirectory(a:folder)
    execute "lua require'telescope.builtin'.find_files({ cwd = '" . a:folder . "', prompt_title = '" . a:title . "' })"
  else
    echo "Directory: '" . a:folder . "' not found in this project..."
  endif
endfunction

function s:InstallConfigs()
  execute "!sh ~/.config/nvim/setup.sh"
endfunction

function s:UpdateNvimOnRails()
  execute "!cd ~/.config/nvim; git pull origin main -f"
endfunction

command! InstallConfigs :call s:InstallConfigs()
command! UpdateNvimOnRails :call s:UpdateNvimOnRails()

silent :InstallConfigs
:PackerInstall

let g:any_jump_disable_default_keybindings = 1

let g:ruby_refactoring_map_keys=0

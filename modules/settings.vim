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

set shiftwidth=2
set tabstop=2
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

set confirm

set clipboard=unnamed,unnamedplus

let g:camelsnek_i_am_an_old_fart_with_no_sense_of_humour_or_internet_culture = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb'

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-q>'
let g:multi_cursor_next_key            = '<C-q>'
let g:multi_cursor_quit_key            = '<Esc>'

" Vim Script
let g:nvim_tree_respect_buf_cwd = 1

lua << EOF
require("nvim-tree").setup({
  update_cwd = true,
  view = {
    mappings = {
      custom_only = false,
    },
  },
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

  write
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
  write
endfunction

function FindInFolder(folder, title)
  if isdirectory(a:folder)
    execute "lua require'telescope.builtin'.find_files({ cwd = '" . a:folder . "', prompt_title = '" . a:title . "' })"
  else
    echo "Directory: '" . a:folder . "' not found in this project..."
  endif
endfunction

function s:CleanConfigs()
  execute "!sh ~/.config/nvim/bin/clean.sh"
endfunction


function s:UpdateMood()
  execute "!cd ~/.config/nvim; git pull origin main -f"
endfunction

let g:last_term_command = []

function RunLastTermCommand()
  execute "call OpenTerm(g:last_term_command[0], g:last_term_command[1], g:last_term_command[2], g:last_term_command[3])"
endfunction

function OpenTerm(command, name, unique, close_after_create)
  let p_name = split(finddir('.git/..', expand('%:p:h').';'), "/")

  if a:name != 'Quick Term'
    let g:last_term_command = [a:command, a:name, a:unique, a:close_after_create]
  end

  if len(p_name) > 0
    let full_name = p_name[-1] . " " . a:name
  else
    let full_name = a:name
  endif

  let bnr = bufexists(full_name)

  if bnr > 0 && a:unique == 1
    execute "bel sb " . full_name

    echo full_name . " exists.  Focusing."
    startinsert
  elseif bnr > 0 && a:unique == 2
    execute "bel sb " . full_name

    execute "normal! :bd\<CR>"

    sleep 150m

    execute "call OpenTerm('" . a:command . "', '" . a:name "', '" . a:unique . "', '" . a:close_after_create . "')"
  else
    if bnr > 0
      let new_number = 0

      while bnr > 0
        let bnr = bufexists(full_name . " - " . new_number)

        if bnr > 0
          let new_number = new_number + 1
        endif
      endwhile

      execute "Term " . a:command
      execute "file! " . full_name . " - " . new_number
    else
      execute "Term " . a:command
      execute "file! " . full_name
    end

    if a:close_after_create == 1
      execute "close"

      echo full_name . " is beign executed in background."
      stopinsert
    else
      echo full_name . " is open!."
    end
  endif
endfunction

command! CleanConfigs :call s:CleanConfigs()
command! UpdateMood :call s:UpdateMood()

:PackerInstall

let g:any_jump_disable_default_keybindings = 1

let g:ruby_refactoring_map_keys=0

function! SplitTermStrategy(cmd)
  execute "call OpenTerm(a:cmd, 'Vim Test', 2, 0)"
endfunction

let g:test#custom_strategies = {'splitterm': function('SplitTermStrategy')}
let g:test#strategy = 'splitterm'

let g:dashboard_default_executive ='telescope'
let g:table_mode_disable_tableize_mappings = 1
let g:table_mode_disable_mappings = 1

xmap gl <Plug>(EasyAlign)
nmap gl <Plug>(EasyAlign)

let g:dashboard_custom_header = [
      \ '███╗   ███╗ ██████╗  ██████╗ ██████╗     ███╗   ██╗██╗   ██╗██╗███╗   ███╗',
      \ '████╗ ████║██╔═══██╗██╔═══██╗██╔══██╗    ████╗  ██║██║   ██║██║████╗ ████║',
      \ '██╔████╔██║██║   ██║██║   ██║██║  ██║    ██╔██╗ ██║██║   ██║██║██╔████╔██║',
      \ '██║╚██╔╝██║██║   ██║██║   ██║██║  ██║    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
      \ '██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██████╔╝    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
      \ '╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝     ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝'
\]


let g:dashboard_custom_section={
  \ '1': {
      \ 'description': [' Open Project                 SPC p  '],
      \ 'command': 'Telescope project' },
  \ '2': {
      \ 'description': ['ﯠ Harpoon                      C-SPC  '],
      \ 'command': 'lua require("harpoon.ui").toggle_quick_menu()' },
  \ '3': {
      \ 'description': [' Git status                   SPC TAB'],
      \ 'command': 'Telescope git_status' },
  \ '4': {
      \ 'description': [' Recent Files                 SPC f r'],
      \ 'command': 'Telescope find_files' },
  \ '5': {
      \ 'description': [' Open Handbook (docs)         SPC h h'],
      \ 'command': 'e ~/.config/nvim/handbook.md' },
  \ '6': {
      \ 'description': [' User Settings                SPC f p'],
      \ 'command': 'e ~/.config/nvim/user.vim' },
  \ '7': {
      \ 'description': [' User Plugins                 SPC f P'],
      \ 'command': 'e ~/.config/nvim/lua/user-plugins.lua' },
  \ '8': {
      \ 'description': [' Edit CoC File                SPC h c'],
      \ 'command': 'CocConfig' },
  \ '9': {
      \ 'description': [' Update mooD                  SPC h u'],
      \ 'command': 'UpdateMood' }
  \ }
let g:machine_gun_regexp = {
      \ 'ruby': 'def\ \|do$\|do |.*|$\|end$'
    \ }

let g:machine_gun_regexp.typescriptreact = '=>\|\}\|\function .*'
let g:machine_gun_regexp.javascript = '=>\|\}\|\function .*'
let g:machine_gun_regexp.solidity = 'function \|modifier \|constructor(.*'
let g:machine_gun_regexp.default = '{\|\}'
let g:machine_gun_regexp.markdown = '^#'
let g:machine_gun_regexp.python = ':$'
let g:machine_gun_regexp.empty = '^>\|Failure\/Error'

function VimMachineGunDown()
  let buftype = getbufvar('', '&filetype', 'ERROR')

  if buftype == ''
    let buftype = 'empty'
  endif

  let command = get(g:machine_gun_regexp, buftype, g:machine_gun_regexp.default)

  try
    execute ":normal! /" . command . "\<CR>"
  catch
  endtry
endfunction

function VimMachineGunUp()
  let buftype = getbufvar('', '&filetype', 'ERROR')

  if buftype == ''
    let buftype = 'empty'
  endif

  let command = get(g:machine_gun_regexp, buftype, g:machine_gun_regexp.default)

  try
    execute ":normal! ?" . command . "\<CR>"
  catch
  endtry
endfunction

function VimMachineGunDownVisual()
  let buftype = getbufvar('', '&filetype', 'ERROR')

  if buftype == ''
    let buftype = 'empty'
  endif

  let command = get(g:machine_gun_regexp, buftype, g:machine_gun_regexp.default)

  try
    execute ":normal! j gv /" . command . "\<CR>j"
  catch
  endtry
endfunction

function VimMachineGunUpVisual()
  let buftype = getbufvar('', '&filetype', 'ERROR')

  if buftype == ''
    let buftype = 'empty'
  endif

  let command = get(g:machine_gun_regexp, buftype, g:machine_gun_regexp.default)

  try
    execute ":normal! k gv /" . command . "?<CR>"
  catch
  endtry
endfunction

noremap <silent><C-j> :call VimMachineGunDown()<CR>
noremap <silent><C-k> :call VimMachineGunUp()<CR>

vnoremap <silent><C-j> :call VimMachineGunDownVisual()<CR>
vnoremap <silent><C-k> :call VimMachineGunUpVisual()<CR>

let g:HowMuch_no_mappings = 1

let bufferline = get(g:, 'bufferline', {})
let bufferline.exclude_ft = ['']

function! FilesColonGrep(query, fullscreen)
  let command_fmt = 'a=%s && rg --with-filename --column --line-number --no-heading --color=always --smart-case -- "${a#*:}" $(rg --files | rg "${a%%:*}") || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang FCG call FilesColonGrep(<q-args>, <bang>0)

augroup rc
au!
au TermOpen * setlocal nobuflisted
augroup END

let g:send_disable_mapping = 1

autocmd BufEnter * ColorizerAttachToBuffer

let test#ruby#rspec#options = { 'file': '--format documentation' }

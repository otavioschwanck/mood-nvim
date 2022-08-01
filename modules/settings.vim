au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
autocmd SwapExists * let v:swapchoice = "e"

set undofile
set cmdheight=1

set nu

autocmd!
scriptencoding utf-8

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
set updatetime=200
set laststatus=2
set scrolloff=10
set expandtab
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
au! BufEnter * let b:visit_time = localtime()

autocmd SwapExists * let v:swapchoice = "e"

set background=dark
set termguicolors

set confirm

set clipboard=unnamed,unnamedplus

let g:camelsnek_i_am_an_old_fart_with_no_sense_of_humour_or_internet_culture = 1

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb'

let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = 'M'
let g:multi_cursor_next_key            = 'M'
let g:multi_cursor_quit_key            = '<Esc>'

lua << EOF
require("nvim-tree").setup({
  update_cwd = false,
  view = {
    hide_root_folder = true,
    mappings = {
      custom_only = false,
    },
  }
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
    execute "%s/.*" . g:ruby_debugger . "\\n//gre"
  endif

  if buftype == "eruby"
    execute "%s/.*<% " . g:ruby_debugger . " %>\\n//gre"
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
  execute "PackerClean"
  execute "PackerInstall"
  execute "PackerUpdate"
endfunction

let g:last_term_command = []

let g:term_as_full_screen_tabs = 0

function OpenTerm(command, name, unique, close_after_create)
  let p_name = split(getcwd(), "/")

  if(g:term_as_full_screen_tabs > 0)
    let change_buffer_command = "tab sb "
    let term_command = "TTerm"

    let b:common_open = 0
  else
    let change_buffer_command = "bel sb "
    let term_command = "Term"

    let b:common_open = 0
  endif

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
    execute change_buffer_command . " " . full_name

    echo full_name . " exists.  Focusing."
    startinsert

    let b:common_open = 0
  elseif bnr > 0 && a:unique == 2
    execute change_buffer_command . " " . full_name

    lua require('mood-scripts.command-on-start').kill_single_terminal(vim.fn.bufnr(vim.api.nvim_eval('full_name')))

    let command_to_run = "call OpenTerm('" . a:command . "', '" . a:name . "', '" . a:unique . "', '" . a:close_after_create . "')"

    call timer_start(300, {-> execute(command_to_run) })
  else
    if bnr > 0
      let new_number = 0

      while bnr > 0
        let bnr = bufexists(full_name . " - " . new_number)

        if bnr > 0
          let new_number = new_number + 1
        endif
      endwhile

      execute term_command . " " . a:command
      execute "file! " . full_name . " - " . new_number
      execute "SendHere"

      let b:common_open = 0
    else
      execute term_command . " " . a:command

      execute "file! " . full_name
      execute "SendHere"

      let b:common_open = 0
    end

    if a:close_after_create == 1
      execute "close"

      if a:name != 'Quick Term'
        lua require('notify')(vim.api.nvim_eval('a:name') .. " is being executed in background.", 'info', { title='Terminal Management' })
      endif

      stopinsert
    end
  endif
endfunction

function ResetRailsDb(command)
  call KillRubyInstances()

  execute "call OpenTerm('" . a:command  . "', 'DB Reset', 2, 0)"
endfunction

function KillRubyInstances()
  execute "silent !killall -9 rails ruby spring bundle"

  lua require('notify')('Ruby Instances killed.', 'info', { title='mooD' })

  call timer_start(2000, {-> execute("LspStart solargraph") })
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

lua <<EOF
local db = require('dashboard')
db.custom_header = {
      '',
      '███╗   ███╗ ██████╗  ██████╗ ██████╗     ███╗   ██╗██╗   ██╗██╗███╗   ███╗',
      '████╗ ████║██╔═══██╗██╔═══██╗██╔══██╗    ████╗  ██║██║   ██║██║████╗ ████║',
      '██╔████╔██║██║   ██║██║   ██║██║  ██║    ██╔██╗ ██║██║   ██║██║██╔████╔██║',
      '██║╚██╔╝██║██║   ██║██║   ██║██║  ██║    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
      '██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██████╔╝    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
      '╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝     ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
      '',
      'Version 1.3.0',
      '',
      ''
}

db.custom_footer = { "" }

db.custom_center = {
  { desc = ' Git status                   ', shortcut = 'SPC TAB', action = 'Telescope git_status' },
  { desc = ' Recent Files                 ', shortcut = 'SPC f r', action = 'Telescope oldfiles' },
  { desc = ' Open Handbook (docs)         ', shortcut = 'SPC h h', action = 'e ~/.config/nvim/handbook.md' },
  { desc = ' User Settings                ', shortcut = 'SPC f p', action = 'e ~/.config/nvim/user.vim' },
  { desc = ' User Plugins                 ', shortcut = 'SPC f P', action = 'e ~/.config/nvim/lua/user-plugins.lua' },
  { desc = ' User LSP                     ', shortcut = 'SPC h l', action = 'e ~/.config/nvim/lua/user_lsp.lua' },
  { desc = ' Update mooD                  ', shortcut = 'SPC h u', action = 'UpdateMood' },
}
EOF

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

function! Wildchar()
    call feedkeys("\<Tab>", 'nt')
    return ''
endfunction

autocmd VimEnter * doautocmd FileType
set completeopt=menu,preview

let g:UltiSnipsSnippetDirectories = ["UltiSnips", "user-snippets"]

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

autocmd VimLeavePre * lua require('quit_neovim')()
autocmd BufReadPost * lua require('mood-scripts.command-on-start').autostart()

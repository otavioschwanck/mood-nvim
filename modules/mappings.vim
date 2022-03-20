let mapleader = " "

function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  if going_to_spec
    let new_file = substitute(new_file, '^app/', '', '')
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    let new_file = 'app/' . new_file
  endif
  return new_file
endfunction

lua << EOF
  require("which-key").setup {}

  local wk = require("which-key")
  -- Visual mode:
   wk.register({
     c = {
       name = "+Lsp and CoC",
       s = { "<Plug>(coc-convert-snippet)", "Convert selection into snippet" },
       a = { "<Plug>(coc-codeaction-selected)", "Code Action" },
       f = { "<Plug>(coc-format-selected)", "Format" },
     },
     m = {
       l = { ":RExtractLet<CR>", "Extract Let" },
       v = { ":RExtractLocalVariable<CR>", "Extract Variable" }
     },
     r = {
       name = "+Refactor",
       e = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function" },
       f = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", "Extract Function To File" },
       v = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
       i = { "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
     }
   }, { mode = "v", prefix = "<leader>" })

  -- Normal mode:
  wk.register({
  x = { "<C-w>c", "Kill Window" },
  ["1"] = { ":lua require('harpoon.ui').nav_file(1)<CR>", 'Harpoon to 1' },
  ["2"] = { ":lua require('harpoon.ui').nav_file(2)<CR>", 'Harpoon to 2' },
  ["3"] = { ":lua require('harpoon.ui').nav_file(3)<CR>", 'Harpoon to 3' },
  ["4"] = { ":lua require('harpoon.ui').nav_file(4)<CR>", 'Harpoon to 4' },
  ["*"] = { ":Telescope grep_string<CR>", "Search string at point on project" },
  ["<space>"] = { ":Telescope find_files<CR>", "Find Files" },
  e = { ":NvimTreeFindFileToggle<CR>", "Toggle Tree" },
  d = { ":call AddDebugger()<CR>", "Add debugger" },
  D = { ":call ClearDebugger()<CR>", "Clear debuggers" },
  u = { ":UndotreeToggle<CR>", "Undo Tree" },
  a = { ":call OpenTestAlternate()<cr>", "Go to Test" },
  l = {
    name = "+Tmux",
    s = { ":Telescope tmux sessions<CR>", "Sessions" },
    w = { ":Telescope tmux windows<CR>", "Windows" },
    p = { ":Telescope tmux pane_contents<CR>", "Pane Contents" },
  },
  h = {
    name = "+Help",
    t = { ":Telescope colorscheme<CR>", "Change Theme" },
    h = { ":e ~/.config/nvim/handbook.md<CR>", "Open the Handbook" },
    c = { ":e ~/.config/nvim/coc-settings.json<CR>", "Coc Settings" },
    u = { ":UpdateNvimOnRails<CR>", "Update Nvim On Rails" },
  },
  A = { "<C-w>o <C-w>v :call OpenTestAlternate()<cr>", "Go to Test (split)" },
  ["."] = { ":Telescope file_browser path=%:p:h hidden=true respect_gitignore=false<CR>", "File Browser" },
  k = { ":call undoquit#SaveWindowQuitHistory()<cr>:bd!<CR>", "Kill current buffer" },
  p = {
    name = "+Projects",
    p = { ":Telescope projects<CR>", "Go To Project" }
  },
  t = {
    name = '+Test',
    v = { ":TestFile<CR>", "Test Current File" },
    s = { ":TestNearest<CR>", "Test Nearest Test" },
    a = { ":TestSuite<CR>", "Test Project" },
  },
  c = {
    name = "+Lsp (COC)",
    r = { "<Plug>(coc-rename)", "Rename" },
    a = { ":Telescope coc code_actions<CR>", "Code Action" },
    l = { "<Plug>(coc-codelens-action)", "Code Lens" },
    x = { ":Telescope coc diagnostics<CR>", "Diagnostics" },
    j = { ":Telescope coc workspace_symbols<CR>", "Symbols" },
    s = { "<Plug>(coc-convert-snippet)", "Convert selection into snippet" },
    o = { ":OR<CR>", "Organize Imports" },
    f = { ":Format<CR>", "Format File" },
    i = { ":Telescope coc document_symbols<CR>", "Search Outline Symbols" }
  },
  ["<return>"] = { ":Telescope resume<CR>", "Telescope Resume" },
  s = {
    name = "+Search",
    p = { ":Telescope live_grep<CR>", "Grep on Project" },
    P = { ":CocSearch ", "Grep using CoC" },
    g = { ":Telescope git_status<CR>", "Search files modified in git" },
    s = { ":Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>", "Fuzzy Current Buffer" },
    i = { ":Telescope coc document_symbols<CR>", "Search Outline Symbols" },
    j = { ":Telescope coc workspace_symbols<CR>", "Symbols" },
  },
  f = {
    name = "+File",
    r = { ":Telescope oldfiles<CR>", "Recent Files" },
    s = { ":w!", "Save" },
    R = { ":Move ", "Rename Current File" },
    D = { ":Delete<CR>", "Delete the current file" },
    p = { ":e ~/.config/nvim/user.vim<CR>", "Open Your Private Files" },
    P = { ":e ~/.config/nvim/lua/user-plugins.lua<CR>", "Open Your Plugin" },
    y = { ":call CopyRelativePath()<CR>", "Copy Relative Path" },
    Y = { ":call CopyFullPath()<CR>", "Copy Full Path" },
    C = { ":saveas ", "Copy current file to" }
  },
  m = {
    name = "+Ruby Refact",
    d = { ":CocCommand rubocop.insert<CR>", "Disable byebug at point" },
    a = { ":RAddParameter<CR>", "Add Parameter" }
  },
  g = {
    name = "+Git",
    g = { ":LazyGit<CR>", "LazyGit" },
    t = { ":0GcLog<CR>:echo 'Use ]q and [q to navigate on file history.  SPC q to close.'<CR>", "Git Time Machine" },
    r = { ":Gitsigns reset_hunk<CR>", "Reset hunk at point" },
    c = { ":Gdiff<CR>", "Diff from HEAD" },
    s = { ":Gitsigns stage_hunk<CR>", "Stage hunk at point" },
    S = { ":Gitsigns stage_buffer<CR>", "Stage buffer" },
    R = { ":Gitsigns reset_buffer<CR>", "Reset buffer" },
    p = { ":Gitsigns preview_hunk<CR>", "Preview Hunk" },
    b = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
    d = { ":Gitsigns diffthis<CR>", "Diff this file" },
    l = { ":GcLog -- %<CR>", "Log this file" },
  },
  [','] = { ":Telescope buffers only_cwd=true<CR>", "Find Buffers in this project" },
  [','] = { ":Telescope buffers<CR>", "Find all buffers" },
  v = { ":call OpenTerm('', 'Quick Term', 1, 0)<CR>", "Open a blank terminal" },
  w = {
    name = "+Window",
    w = { "<C-w>w", "Next Window" },
    W = { "<C-w>W", "Previous Windows" },
    o = { "<C-w>o", "Maximize Window" },
    u = { "<C-w>u", "Restore killed window" },
    c = { ":call undoquit#SaveWindowQuitHistory()<cr><c-w>c", "Close Window" },
    q = { ":call undoquit#SaveWindowQuitHistory()<cr><c-w>c", "Kill Window" },
    x = { "<C-w>x", "Swap windows" },
    v = { "<C-w>v", "Split Vertical" },
    s = { "<C-w>s", "Split Horizontal" }
  },
  q = {
    name = "+Quit and Close",
    q = { ":qall<CR>", "Quit Vim" },
    c = {":cclose<CR>", "Quick Fix Close"}
  }
}, { prefix = "<leader>", silent = false })
EOF

nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k

" Git Signs
nmap ]g <cmd>Gitsigns next_hunk<CR>
nmap [g <cmd>Gitsigns prev_hunk<CR>

function HideTerminalWindowOrNoh()
  let buftype = getbufvar('', '&buftype', 'ERROR')

  if buftype == 'terminal'
    execute "close"
  else
    execute "noh"
  end
endfunction

" Clear highlight
nnoremap <silent><esc> :call HideTerminalWindowOrNoh()<CR>

" Quickfix
nmap ]q :cnext<CR>
nmap [q :cprevious<CR>

" Save all
nmap \ :wall<CR>
nmap ç :wall<CR>

nmap - $
vmap - $<Left>

nnoremap gr :NvimTreeRefresh<CR>

nnoremap H :BufMRUPrev<CR>
nnoremap L :BufMRUNext<CR>

nnoremap <TAB> <C-w>w
nnoremap <S-TAB> <C-w>W

nnoremap <C-s> :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-space> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nmap s :HopChar1<CR>

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

function Setreg(regname, regval)
  exe "let @".a:regname." = '".a:regval."'"
endfunction

function CopyRelativePath()
    let value = expand("%")
    call Setreg("*", value)
    call Setreg("+", value)
    echom "Yanked: " . value
endfunction

function CopyFullPath()
  let value = expand("%:p")
  call Setreg("*", value)
  call Setreg("+", value)
  echom "Yanked: " . value
endfunction

nnoremap gh :SidewaysLeft<cr>
nnoremap gl :SidewaysRight<cr>

nmap vij vaI
nmap vaj vaIj

nmap dij daI
nmap daj vaIjd

nmap cij caI
nmap caj vaIjc

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap <c-w>c :call undoquit#SaveWindowQuitHistory()<cr><c-w>c

" Big Improvements
imap <C-v> <C-r>+
cnoremap <C-v> <C-r>+
cnoremap <C-a> <C-left>
cnoremap <C-e> <C-right>

vnoremap < <gv
vnoremap > >gv

xmap q iq
omap q iq

omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

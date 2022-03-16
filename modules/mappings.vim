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
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<workers\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1  || match(current_file, '\<services\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction

lua << EOF
  require("which-key").setup {}

  local wk = require("which-key")
  -- Visual mode:
   wk.register({
     c = {
       name = "+Lsp",
       a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" }
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
  ["1"] = { ":lua require('harpoon.ui').nav_file(1)<CR>", 'Harpoon to 1' },
  ["2"] = { ":lua require('harpoon.ui').nav_file(2)<CR>", 'Harpoon to 2' },
  ["3"] = { ":lua require('harpoon.ui').nav_file(3)<CR>", 'Harpoon to 3' },
  ["4"] = { ":lua require('harpoon.ui').nav_file(4)<CR>", 'Harpoon to 4' },
  ["*"] = { ":Telescope grep_string<CR>", "Search string at point on project" },
  ["<space>"] = { ":Telescope find_files<CR>", "Find Files" },
  e = { ":NvimTreeFindFileToggle<CR>", "Toggle Tree" },
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
    h = { ":e ~/.config/nvim/handbook.md<CR>", "Open the Handbook" }
  },
  A = { "<C-w>o <C-w>v :call OpenTestAlternate()<cr>", "Go to Test (split)" },
  ["."] = { ":NvimTreeFindFileToggle<CR>", "Toggle Tree" },
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
    name = "+Lsp",
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    x = { ":Telescope diagnostics<CR>", "Diagnostics" },
    j = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Symbols" },
    i = { ":Telescope lsp_document_symbols<CR>", "Search Outline Symbols" }
  },
  ["<return>"] = { ":Telescope resume<CR>", "Telescope Resume" },
  s = {
    name = "+Search",
    p = { ":Telescope live_grep<CR>", "Grep on Project" },
    g = { ":Telescope git_status<CR>", "Search files modified in git" },
    s = { ":Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>", "Fuzzy Current Buffer" },
    i = { ":Telescope lsp_document_symbols<CR>", "Search Outline Symbols" },
    j = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Symbols" },
  },
  f = {
    name = "+File",
    r = { ":Telescope oldfiles<CR>", "Recent Files" },
    R = { ":Move ", "Rename Current File" },
    D = { ":Delete<CR>", "Delete the current file" },
    p = { ":e ~/.config/nvim/user.vim<CR>", "Open Your Private Files" },
    y = { ":call CopyRelativePath()<CR>", "Copy Relative Path" },
    Y = { ":call CopyFullPath()<CR>", "Copy Full Path" },
    C = { ":saveas ", "Copy current file to" }
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
  [','] = { ":Telescope buffers<CR>", "Find Buffers" },
  v = { ":Term<CR>", "Open a blank terminal" },
  q = { ":cclose<CR>", "Quick Fix Close" }
}, { prefix = "<leader>", silent = false })
EOF

nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k

" Git Signs
nmap ]g <cmd>Gitsigns next_hunk<CR>
nmap [g <cmd>Gitsigns prev_hunk<CR>

" Clear highlight
nnoremap <silent><esc> :noh<return><esc>

" Quickfix
nmap ]q :cnext<CR>
nmap [q :cprevious<CR>
nnoremap <silent>H :BufMRUPrev<CR>
nnoremap <silent>L :BufMRUNext<CR>

" Save all
nmap \ :wall<CR>
nmap ç :wall<CR>

nmap - $
vmap - $<Left>

nnoremap gr :NvimTreeRefresh<CR>
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

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nmap <C-j> ]=
nmap <C-k> [=
vmap <C-j> ]=
vmap <C-k> [=

imap <C-f> <Right>
imap <C-b> <Left>

nmap gd :Telescope lsp_definitions<CR>
nmap gD :Telescope lsp_references<CR>
nmap gi :Telescope lsp_implementations<CR>
nmap gt :Telescope lsp_implementations<CR>

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap <c-w>c :call undoquit#SaveWindowQuitHistory()<cr><c-w>c

inoremap <S-Tab> <C-d>

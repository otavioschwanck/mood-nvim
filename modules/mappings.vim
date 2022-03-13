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
  require("which-key").setup {
    ignore_missing = true
  }

  local wk = require("which-key")
  -- Visual mode:
   wk.register({
     c = {
       name = "+Lsp and CoC",
       s = { "<Plug>(coc-convert-snippet)", "Convert selection into snippet" },
       a = { "<Plug>(coc-codeaction-selected)", "Code Action" },
       f = { "<Plug>(coc-format-selected)", "Format" },
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
  A = { ":AV<CR>", "Go to Test (split)" },
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
    s = { ":Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>", "Fuzzy CUrrent Buffer" },
    i = { ":Telescope coc document_symbols<CR>", "Search Outline Symbols" },
    j = { ":Telescope coc workspace_symbols<CR>", "Symbols" },
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

nmap - $
vmap - $<Left>

nnoremap gr :NvimTreeRefresh<CR>
nnoremap <TAB> <C-w>w

nnoremap <C-s> :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-space> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nmap s <Plug>(easymotion-overwin-f)

let g:EasyMotion_do_mapping = 0 " Disable default mappings

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

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap <c-w>c :call undoquit#SaveWindowQuitHistory()<cr><c-w>c

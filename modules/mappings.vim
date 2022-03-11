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
  h = {
    name = "+Help",
    t = { ":Telescope colorscheme<CR>", "Change Theme" },
    h = { ":e ~/.config/nvim/handbook.md<CR>", "Open the Handbook" }
  },
  A = { ":AV<CR>", "Go to Test (split)" },
  ["."] = { ":NvimTreeFindFileToggle<CR>", "Toggle Tree" },
  k = { ":bd!<CR>", "Kill current buffer" },
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
    f = { "<Plug>(coc-format-selected)", "Format" },
    a = { "<Plug>(coc-codeaction)", "Code Action" },
    F = { "<Plug>(coc-fix-current)", "Fix Current File" },
    l = { "<Plug>(coc-codelens-action)", "Code Lens" },
    x = { ":<C-u>CocList diagnostics<cr>", "Diagnostics" },
    j = { ":<C-u>CocList -I symbols<cr>", "Symbols" },
    s = { "<Plug>(coc-convert-snippet)", "Convert selection into snippet" },
    ["!"] = { ":<C-u>CocListResume<CR>", "Resume" }
  },
  s = {
    name = "+Search",
    p = { ":Telescope live_grep<CR>", "Grep on Project" },
    P = { ":CocSearch ", "Grep using CoC" },
    s = { ":Telescope git_status<CR>", "Search files modified in git" },
    i = { ":CocList outline<CR>", "Search Outline Symbols" }
  },
  f = {
    name = "+File",
    r = { ":Telescope frecency<CR>", "Recent Files" },
    R = { ":Move ", "Rename Current File" },
    D = { ":Delete<CR>", "Delete the current file" },
    p = { ":e ~/.config/nvim/user.vim<CR>", "Open Your Private Files" }
  },
  g = { 
    name = "+Git",
    g = { ":LazyGit<CR>", "LazyGit" },
    r = { ":Gitsigns reset_hunk<CR>", "Reset hunk at point" },
    s = { ":Gitsigns stage_hunk<CR>", "Stage hunk at point" },
    S = { ":Gitsigns stage_buffer<CR>", "Stage buffer" },
    R = { ":Gitsigns reset_buffer<CR>", "Reset buffer" },
    p = { ":Gitsigns preview_hunk<CR>", "Preview Hunk" },
    b = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
    d = { ":Gitsigns diffthis<CR>", "Diff this file" },
    l = { ":GcLog %<CR>", "Log this file" }
  },
  [','] = { ":Telescope buffers<CR>", "Find Buffers" },
  v = { ":Term<CR>", "Open a blank terminal" }
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
nnoremap <silent>H :bp<CR>
nnoremap <silent>L :bn<CR>

" Save all
nmap \ :wall<CR>

nmap - $
vmap - $<Left>

nnoremap gr :NvimTreeRefresh<CR>

nnoremap <C-s> :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-space> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nmap s <Plug>(easymotion-overwin-f)

let g:EasyMotion_do_mapping = 0 " Disable default mappings

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

nnoremap <silent> <C-q>    :BufferPick<CR>

" copy current file name (relative/absolute) to system clipboard
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>fy :let @*=expand("%")<CR>

  " absolute path  (/something/src/foo.txt)
  nnoremap <leader>fY :let @*=expand("%:p")<CR>
endif

" copy current file name (relative/absolute) to system clipboard (Linux version)
if has("gui_gtk") || has("gui_gtk2") || has("gui_gnome") || has("unix")
  " relative path (src/foo.txt)
  nnoremap <leader>fy :let @+=expand("%")<CR>

  " absolute path (/something/src/foo.txt)
  nnoremap <leader>fY :let @+=expand("%:p")<CR>
endif

nnoremap gh :SidewaysLeft<cr>
nnoremap gl :SidewaysRight<cr>

nmap vij vaI

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

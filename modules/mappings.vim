let mapleader = " "

function OpenTestAlternateAndSplit()
  let win_count = winnr()
  let test_path = eval('rails#buffer().alternate()')

  execute "normal! \<C-w>o"

  execute "norm \<C-w>v"

  execute "call OpenTestAlternate()"

  if test_path =~ 'app/'
    execute "norm \<C-w>x"
  endif
endfunction

function OpenTestAlternate()
  let test_path = eval('rails#buffer().alternate()')

  execute "e " . test_path

  if !filereadable(test_path) && join(getline(1,'$'), "\n") == ''
    if test_path =~ "spec/"
      execute "norm itemplate_test\<Tab>"
    else
      execute "norm iminitest\<Tab>"
    endif
  endif
endfunction

nmap gq yiw:%s/<C-r>"//gr<Left><Left><Left>
nmap gQ yiw:%S/<C-r>"//gr<Left><Left><Left>
xnoremap gq y:%s/<C-r>"//gr<Left><Left><Left>
xnoremap gQ y:%S/<C-r>"//gr<Left><Left><Left>

lua << EOF
  require("which-key").setup {}

  local wk = require("which-key")
  -- Visual mode:
   wk.register({
     h = {
        name = "+Calculate",
        s = { "<Plug>AutoCalcAppendWithSum", "Sum" },
        ["?"] = { "<Plug>AutoCalcAppend", "Auto Calculation" },
     },
     n = {
       name = "+Toggle Case",
       s = { ":Snake<CR>", "snake_case" },
       c = { ":Camel<CR>", "camelCase" },
       b = { ":CamelB<CR>", "CamelCaseB" }
     },
     c = {
       name = "+Lsp and CoC",
       s = { "<Plug>(coc-convert-snippet)", "Convert selection into snippet" },
       a = { "<Plug>(coc-codeaction-selected)", "Code Action" },
       f = { "<Plug>(coc-format-selected)", "Format" },
     },
     m = {
       name = "+Ruby Extract",
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
  ["-"] = { "migg=G\'i:w<CR>", "Indent Current File" },
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
  n = {
    name = "+Toggle Case",
    s = { ":Snake<CR>", "snake_case" },
    c = { ":Camel<CR>", "camelCase" },
    b = { ":CamelB<CR>", "CamelCaseB" }
  },
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
    u = { ":UpdateMood<CR>", "Update mooD" },
  },
  A = { ":call OpenTestAlternateAndSplit()<cr>", "Go to Test (split)" },
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
  ['<tab>'] = { ":Telescope buffers<CR>", "Find all buffers" },
  b = {
    name = "+Buffer",
    p = { ":BufferPrevious<CR>", "Previous" },
    n = { ":BufferNext<CR>", "Next" },
    N = { ":tabnew<CR>", "New Empty Buffer" },
    f = { ":Telescope buffers only_cwd=true<CR>", "Find Buffers in this project" },
    F = { ":Telescope buffers<CR>", "Find all buffers" },
    b = { ":BufferPick<CR>", "Pick Buffer" },
    o = { ":BufferOrderByDirectory<CR>", "Order tabs by directory" },
    O = { ":BufferOrderByLanguage<CR>", "Order tabs by language" },
    c = { ":BufferCloseAllButCurrent<CR>", "Close All But Current" },
  },
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

nmap <M-l> <C-w>l
nmap <M-h> <C-w>h
nmap <M-j> <C-w>j
nmap <M-k> <C-w>k

" Git Signs
nmap ]g <cmd>Gitsigns next_hunk<CR>
nmap [g <cmd>Gitsigns prev_hunk<CR>

xnoremap <silent><expr> A mode() ==# "V" ? "<C-v>$A" : "A"
xnoremap <silent><expr> I mode() ==# "V" ? "<C-v>$^I" : "I"
xnoremap <silent><expr> i mode() ==# "V" ? "<C-v>$0I" : "i"

function HideTerminalWindowOrNoh()
  let buftype = getbufvar('', '&buftype', 'ERROR')

  if buftype == 'terminal'
    execute "normal! G{}"

    if getline('.') == ''
      execute "normal! k"
    endif

    if getline('.') =~ "Process exited"
      execute "normal! :bd\<CR>"
    else
      if winnr('$') == 1
        execute "b#"
      else
        execute "close"
      end
    end
  end
endfunction

" Clear highlight
nnoremap <silent><esc> :call HideTerminalWindowOrNoh()<CR>:noh<CR>

" Quickfix
nmap ]q :cnext<CR>
nmap [q :cprevious<CR>

" Save all
nmap \ :wall<CR>
nmap ç :wall<CR>

nmap - $
vmap - $<Left>

nnoremap gr :NvimTreeRefresh<CR>

nnoremap H :BufferPrevious<CR>
nnoremap L :BufferNext<CR>

nnoremap ; :BufferPick<CR>
nnoremap <tab> <C-w>w
nnoremap <S-tab> <C-w>W

nnoremap <C-s> :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-space> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nmap s :HopChar1<CR>
nmap S :Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>

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

nnoremap <C-h> :SidewaysLeft<cr>
nnoremap <C-l> :SidewaysRight<cr>

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

nmap  <C-q>  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

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
      execute "norm itemplate_test\<C-j>"
    else
      execute "norm iminitest\<C-j>"
    endif
  endif
endfunction

nmap <leader>1 :BufferGoto 1<CR>
nmap <leader>2 :BufferGoto 2<CR>
nmap <leader>3 :BufferGoto 3<CR>
nmap <leader>4 :BufferGoto 4<CR>
nmap <leader>5 :BufferGoto 5<CR>
nmap <leader>6 :BufferGoto 6<CR>
nmap <leader>7 :BufferGoto 7<CR>
nmap <leader>8 :BufferGoto 8<CR>
nmap <leader>9 :BufferGoto 9<CR>

nmap gq "jyiw:%s/<C-r>"//gr<Left><Left><Left>
nmap gQ "jyiw:%S/<C-r>"//gr<Left><Left><Left>
xnoremap gq "jy:%s/<C-r>"//gr<Left><Left><Left>
xnoremap <expr> gQ mode() ==# "V" ? ':S//gr<Left><Left><Left><C-r>"/' : '"jy:%S/<C-r>"//gr<Left><Left><Left>'
xnoremap <expr> gq mode() ==# "V" ? ':s//gr<Left><Left><Left><C-r>"/' : '"jy:%s/<C-r>"//gr<Left><Left><Left>'
xnoremap <expr> g\!Q mode() ==# "V" ? ':S//gr<Left><Left><Left>' : '"jy:%S/<C-r>"//gr<Left><Left><Left>'
xnoremap <expr> g\!q mode() ==# "V" ? ':s//gr<Left><Left><Left>' : '"jy:%s/<C-r>"//gr<Left><Left><Left>'

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
       c = { ":Camel<CR>", "CamelCase" },
       b = { ":CamelB<CR>", "camelCaseB" }
     },
     z = {
       n = { ":NoteFromSelectedText<CR>", "New Note from Selected Text" }
     },
     l = { "<Plug>Send", "Send Text to Term" },
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
  ["1"] = "which_key_ignore",
  ["2"] = "which_key_ignore",
  ["3"] = "which_key_ignore",
  ["4"] = "which_key_ignore",
  ["5"] = "which_key_ignore",
  ["6"] = "which_key_ignore",
  ["7"] = "which_key_ignore",
  ["8"] = "which_key_ignore",
  ["9"] = "which_key_ignore",
  i = { ":lua require('harpoon.ui').toggle_quick_menu()<CR>", "Edit Harpoon" },
  [";"] = { ":Telescope buffers ignore_current_buffer=true sort_mru=true<CR>", "Find All Buffers" },
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
  l = { ":lua require('custom_telescope').terminals(require('telescope.themes').get_ivy{})<CR>", "List All Terminals" },
  L = { ":SendHere<CR>", "List All Terminals" },
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
  p = { ":lua require'telescope'.extensions.project.project{}<CR>", "Go To Project" },
  t = {
    name = '+Test',
    v = { ":TestFile<CR>", "Test Current File" },
    s = { ":TestNearest<CR>", "Test Nearest Test" },
    a = { ":TestSuite<CR>", "Test Project" },
    r = { ":TestLast<CR>", "Rerun Last Test" },
  },
  z = {
    name = '+Notes',
    n = { ":Note<CR>", "New Note" },
    z = { ":Note ", "Find Note" },
    s = { ":SearchNotes ", "Search inside notes" },
    d = { ":DeleteNote<CR>", "Delete Current Note" },
    m = { ":NoteToMarkdown<CR>", "Convert Note do Markdown" },
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
    i = { ":call TelescopeDocumentSymbols()<CR>", "Search Outline Symbols" }
  },
  ["<return>"] = { ":Telescope resume<CR>", "Telescope Resume" },
  s = {
    name = "+Search",
    D = { ":lua require('custom_telescope').live_grep_in_folder(require('custom_telescope').terminals(require('telescope.themes').get_ivy{}))<CR>", 'Search text in one or more folders' },
    d = { ":lua require('telescope.builtin').live_grep { search_dirs = {vim.fn.expand('%:p:h')}, prompt_title = 'Live grep inside ' .. vim.fn.expand('%:p:h') }<CR>", 'Search text in some folder' },
    p = { ":lua require('custom_telescope').ripgrep()<CR>", "Search text on Project" },
    P = { ":CocSearch ", "Search text using CoC (for search and replace)" },
    s = { ":Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>", "Fuzzy Current Buffer" },
    i = { ":call TelescopeDocumentSymbols()<CR>", "Search Outline Symbols" },
    j = { ":Telescope coc workspace_symbols<CR>", "Symbols" },
  },
  f = {
    name = "+File",
    r = { ":Telescope oldfiles<CR>", "Recent Files" },
    s = { ":w!", "Save" },
    R = { ":call BetterRename()<CR>", "Rename Current File" },
    M = { ":call BetterMove()<CR>", "Move Current FIle" },
    D = { ":Delete<CR>", "Delete the current file" },
    p = { ":e ~/.config/nvim/user.vim<CR>", "Open Your Private Files" },
    P = { ":e ~/.config/nvim/lua/user-plugins.lua<CR>", "Open Your Plugin" },
    y = { ":call CopyRelativePath()<CR>", "Copy Relative Path" },
    Y = { ":call CopyFullPath()<CR>", "Copy Full Path" },
    C = { ":call BetterCopy()<CR>", "Copy current file to" }
  },
  m = {
    name = "+Ruby Refact",
    d = { ":CocCommand rubocop.insert<CR>", "Disable byebug at point" },
    a = { ":RAddParameter<CR>", "Add Parameter" },
       c = { ":call GetClassName()<CR>", "Copy Class Name to Clipboard" },
  },
  ["!"] = { ":call RunLastTermCommand()<CR>", "Run Last Terminal Command" },
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
    B = { ":Telescope git_branches<CR>", "Change Branch" }
  },
  [','] = { ":Telescope buffers only_cwd=true ignore_current_buffer=true sort_mru=true<CR>", "Find Buffers in this project" },
  ['<tab>'] = { ":Telescope git_status<CR>", "Git Modified Files" },
  b = {
    name = "+Buffer",
    p = { ":silent BufferPrevious<CR>", "Previous" },
    n = { ":silent BufferNext<CR>", "Next" },
    N = { ":e ~/.nvim-scratch<CR>", "Open Scratch Buffer" },
    f = { ":Telescope buffers only_cwd=true<CR>", "Find Buffers in this project" },
    F = { ":Telescope buffers<CR>", "Find all buffers" },
    C = { ":BufferCloseAllButCurrent<CR>", "Close All But Current" },
    c = { ":BufferCloseAllButPinned<CR>", "Close All But Pinned" },
    b = { ":BufferPin<CR>", "Pin Buffer" },
    s = { ":BufferOrderByLanguage<CR>", "Sort By Language" },
    S = { ":BufferOrderByDirectory<CR>", "Sort By Directory" },
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
xnoremap <silent><expr> i mode() ==# "V" ? "<C-v>$\<Home>I" : "i"

function HideTerminalWindowOrNoh()
  let buftype = getbufvar('', '&buftype', 'ERROR')

  if buftype == 'terminal'
    if winnr('$') == 1
      execute "b#"
    else
      execute "close"
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

nmap <silent> H :BufferPrevious<CR>
nmap <silent> L :BufferNext<CR>

nmap <C-h> :BufSurfBack<CR>
nmap <C-l> :BufSurfForward<CR>

let bufferline.icon_pinned = '車'

nnoremap <silent> <C-e>1 :lua require('harpoon.ui').nav_file(1)<CR>
nnoremap <silent> <C-e>2 :lua require('harpoon.ui').nav_file(2)<CR>
nnoremap <silent> <C-e>3 :lua require('harpoon.ui').nav_file(3)<CR>>
nnoremap <silent> <C-e>4 :lua require('harpoon.ui').nav_file(4)<CR>>
nnoremap <silent> <C-e>4 :lua require('harpoon.ui').nav_file(5)<CR>>
nnoremap <silent> <C-e>6 :lua require('harpoon.ui').nav_file(6)<CR>>
nnoremap <silent> <C-e>7 :lua require('harpoon.ui').nav_file(7)<CR>>
nnoremap <silent> <C-e>8 :lua require('harpoon.ui').nav_file(8)<CR>>
nnoremap <silent> <C-e>9 :lua require('harpoon.ui').nav_file(9)<CR>
nnoremap <silent> <C-s> :BufferPick<CR>

nnoremap , <C-w>W
nnoremap ; <C-w>w

nnoremap M :lua require("harpoon.mark").add_file()<CR>
nnoremap <C-space> :Telescope harpoon marks<CR>

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

let g:choosewin_overlay_enable = 1

function GetClassName()
  let filetype = getbufvar('', '&filetype', 'ERROR')

  if filetype == 'ruby'
    let modules = getline(1, '$')->filter({_,line -> line =~ 'module\|class \w'})

    let class_name = ''
    let keep_while = 1
    let index = 0

    if modules == []
      let keep_while = 0
    endif

    while keep_while == 1
      let kind = split(modules[index], ' ')[0]
      let name = split(modules[index], ' ')[1]

      let class_name = class_name . name

      if kind == 'class' || index >= (len(modules) - 1)
        let keep_while = 0
      else
        let index = index + 1
        let class_name = class_name . '::'
      endif
    endwhile

    call setreg('+', class_name)
    call setreg('*', class_name)

    if class_name != ''
      echo "Copied to clipboard: " . class_name
    else
      echo "No class or module found"
    endif
  endif
endfunction

function BetterMove()
    let current_folder = expand('%:p:h')

    call feedkeys(":Move " . current_folder . "/", 'n')
endfunction

function BetterRename()
    let current_file = expand("%p")
    let current_file_name = expand("%:t")
    let new_name = input("New name for " . current_file_name . ": ", current_file_name)
    let current_folder = expand('%:p:h')

    if(new_name != '' && new_name != current_file_name)
       call feedkeys(":saveas " . current_folder . "/" . new_name . "\<CR>", "n")
       call delete(current_file)
       call feedkeys(":bd #\<CR>")
    endif
endfunction

function BetterCopy()
    let current_folder = expand('%:p:h')

    call feedkeys(":saveas " . current_folder . "/", 'n')
endfunction

nnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"
vnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"

nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

imap <C-f> <Right>
imap <C-a> <C-o>0
imap <C-e> <C-o>-
imap <C-b> <Left>

nmap gF <C-w>f
imap <C-d> <Delete>

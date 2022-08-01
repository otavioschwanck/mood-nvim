let mapleader = " "
function OpenTestAlternateAndSplit()
  let win_count = luaeval('require("utils.buf_count")()')
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

function! WordForGq()
  let l:word = substitute(getreg('"'), "\\", "\\\\", "gre")
  let l:word = substitute(l:word, "[", "\\\\[", "gre")
  let l:word = substitute(l:word, "]", "\\\\]", "gre")
  let l:word = substitute(l:word, "/", "\\\\/", "gre")
  let l:word = substitute(l:word, "\\*", "\\\\*", "gre")
  let l:word = substitute(l:word, "\\$", "\\\\$", "gre")
  let l:word = substitute(l:word, "\\~", "\\\\~", "gre")
  let l:word = substitute(l:word, "\\^", "\\\\^", "gre")
  let l:word = substitute(l:word, "\\.", "\\\\.", "gre")

  return l:word
endfunction

nmap gq "jyiwmo:,$s/<C-r>=WordForGq()<CR>//gcie\|1,''-&&\|:norm `ozz<c-b><c-e><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
nmap gQ "jyiwmo:,$S/<C-r>=WordForGq()<CR>//gcie\|1,''-&&\|:norm `ozz<c-b><c-e><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
xnoremap gq "jymo:,$s/<C-r>=WordForGq()<CR>//gcie\|1,''-&&\|:norm `ozz<c-b><c-e><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
xnoremap gQ "jymo:,$S/<C-r>=WordForGq()<CR>//gcie\|1,''-&&\|:norm `ozz<c-b><c-e><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

nmap ; :lua require("harpoon-menu")()<CR>

lua << EOF
require("which-key").setup {}

local wk = require("which-key")

wk.register({
h = {
  name = "+Calculate",
  s = { "<Plug>AutoCalcAppendWithSum", "Sum" },
  ["?"] = { "<Plug>AutoCalcAppend", "Auto Calculation" },
  },
["<C-g>"] = { ":<c-u>call AppendSelectionToQuickConsult()<CR>", "Append Selection" },
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
  name = "+Lsp",
  a = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "Code Action" }
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
[";"] = { ":Telescope buffers ignore_current_buffer=true sort_mru=true<CR>", "Find All Buffers" },
["*"] = { ":Telescope grep_string<CR>", "Search string at point on project" },
["<space>"] = { ":Telescope find_files<CR>", "Find Files" },
e = { ":NvimTreeToggle<CR>", "Toggle Tree" },
E = { ":NvimTreeFindFileToggle<CR>", "Tree Find File" },
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
l = { ":lua require('custom_telescope').terminals()<CR>", "List All Terminals" },
L = { ":SendHere<CR>", "Mark Terminal to Send Text" },
h = {
  name = "+Help",
  t = { ":Telescope colorscheme<CR>", "Change Theme" },
  h = { ":e ~/.config/nvim/handbook.md<CR>", "Open the Handbook" },
  l = { ":e ~/.config/nvim/lua/user_lsp.lua<CR>", "LSP Settings" },
  u = { ":UpdateMood<CR>", "Update mooD" },
  d = { ":!rm -rf ~/.local/share/nvim/swap/*<CR>", "Delete SWP files" },
  r = { ":LspRestart<CR>", "Restart LSP" }
  },
A = { ":call OpenTestAlternateAndSplit()<cr>", "Go to Test (split)" },
["."] = { ":Telescope file_browser path=%:p:h hidden=true respect_gitignore=false<CR>", "File Browser" },
k = { ":Bwipeout<CR>", "Kill current buffer" },
y = { ":Telescope neoclip<CR><ESC>:echo 'Press ENTER to select, C-p to paste before or C-n to paste after.'<CR>", "Yank History" },
 ["<C-g>"] = {
   name = "+QuickConsult",
   a = { ":call AppendClipboardToQuickConsult()<CR>", "Append Text From Clipboard to Quick Consult" },
   s = { ":call SaveClipboardToQuickConsult()<CR>", "Save Text From Clipboard to Quick Consult" }
 },
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
  name = "+Lsp",
  w = {
    name = "+Workspace",
    a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add Workspace' },
    r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove Workspace' },
    l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List Workspaces' },
    },
  x = { ':Telescope diagnostics<CR>', 'Diagnostics' },
  X = { ':Telescope diagnostics<CR>', 'Diagnostics' },
  r = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename' },
  a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Action' },
  f = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format' },
  i = { ':Telescope lsp_document_symbols<CR>', 'Document Symbols' },
  j = { ':Telescope lsp_dynamic_workspace_symbols<CR>', 'Workspace Symbols' },
  },
["<return>"] = { ":Telescope resume<CR>", "Telescope Resume" },
s = {
  name = "+Search",
  D = { ":lua require('custom_telescope').live_grep_in_folder()<CR>", 'Search text in one or more folders' },
  d = { ":lua require('telescope.builtin').live_grep { search_dirs = {vim.fn.expand('%:p:h')}, prompt_title = 'Live grep inside ' .. vim.fn.expand('%:p:h') }<CR>", 'Search text in some folder' },
  p = { ":Telescope live_grep<CR>", "Search text on Project" },
  o = { ":Telescope live_grep grep_open_files=true<CR>", "Search on Open Files" },
  P = { ":lua require('custom_telescope').ripgrep()<CR>", "Advanced Search text on Project" },
  f = { ":CtrlSF ", "Search text using CoC (for search and replace)" },
  s = { ":Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>", "Fuzzy Current Buffer" },
  i = { ":Telescope lsp_document_symbols<CR>", "Search Outline Symbols" },
  j = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Symbols" },
  },
f = {
  name = "+File",
  o = { ":AerialToggle<CR>", "Show Window Symbols" },
  a = { ":OtherClear<CR>:Other<CR>", "Alternate File" },
  A = { ":OTherClear<CR>:OtherVSplit<CR>", "Alternate File Split" },
  r = { ":Telescope oldfiles<CR>", "Recent Files" },
  s = { ":w!", "Save" },
  R = { ":call BetterRename()<CR>", "Rename Current File" },
  M = { ":call BetterMove()<CR>", "Move Current File" },
  D = { ":call BetterDelete()<CR>", "Delete the current file" },
  p = { ":e ~/.config/nvim/user.vim<CR>", "Open Your Private Files" },
  P = { ":e ~/.config/nvim/lua/user-plugins.lua<CR>", "Open Your Plugin" },
  y = { ":call CopyRelativePath()<CR>", "Copy Relative Path" },
  l = { ":call CopyRelativePathWithLine()<CR>", "Copy Path With Line" },
  Y = { ":call CopyFullPath()<CR>", "Copy Full Path" },
  C = { ":call BetterCopy()<CR>", "Copy current file to" }
  },
m = {
  name = "+Ruby",
  a = { ":RAddParameter<CR>", "Add Parameter" },
  c = { ":call GetClassName()<CR>", "Copy Class Name to Clipboard" },
  d = { ":lua require('mood').comment_rubocop()<CR>", "Comment Rubocop Error" },
  },
["#"] = { ":lua require('mood-scripts.command-on-start').restart(true)<CR>", "Execute / Re-excute project terminals" },
["%"] = { ":lua require('mood-scripts.command-on-start').restart_all()<CR>", "TMUX: Execute / Re-execute project terminal all" },
["!"] = { ":call RunLastTermCommand()<CR>", "Run Last Terminal Command" },
["i"] = { ":call OpenTermFromLastCommand()<CR>", "Open Term From Last Command" },
g = {
  name = "+Git",
  g = { ":LazyGit<CR>", "LazyGit" },
  t = { ":lua require('agitator').git_time_machine()<CR>", "Git Time Machine" },
  T = { ":DiffviewFileHistory %<CR>:echo 'Use SPC q d or :DiffviewClose to quit.'<CR>", "File History" },
  r = { ":Gitsigns reset_hunk<CR>", "Reset hunk at point" },
  c = { ":Gdiff<CR>", "Diff from HEAD" },
  s = { ":Gitsigns stage_hunk<CR>", "Stage hunk at point" },
  S = { ":Gitsigns stage_buffer<CR>", "Stage buffer" },
  R = { ":Gitsigns reset_buffer<CR>", "Reset buffer" },
  p = { ":Gitsigns preview_hunk<CR>", "Preview Hunk" },
  b = { ":lua require('agitator').git_blame_toggle()<CR>", "Toggle current line blame" },
  d = { ":DiffviewOpen<CR>:echo 'Use SPC q d or :DiffviewClose to quit.'<CR>", "Git Diff" },
  l = { ":DiffviewFileHistory<CR>:echo 'Use SPC q d or :DiffviewClose to quit.'<CR>", "Log Commits" },
  B = { ":Telescope git_branches<CR>", "Change Branch" }
  },
[','] = { ":Telescope buffers only_cwd=true ignore_current_buffer=true sort_mru=true<CR>", "Find Buffers in this project" },
['<tab>'] = { ":Telescope git_status<CR>", "Git Modified Files" },
v = { ":call OpenTerm('', 'Quick Term', 1, 0)<CR>", "Open a blank terminal" },
j = {
  name = "+Rest",
  r = { "<Plug>RestNvim<CR>", "Run" },
  R = { "<Plug>RestNvimLast<CR>", "Run Last" },
  p = { "<Plug>RestNvimPreview<CR>", "Preview" },
  m = { ":set filetype=http<CR>", "Set Current File as HTTP" },
  h = { ":!open https://github.com/NTBBloodbath/rest.nvim/tree/main/tests", "See Examples of usages" },
},
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
    s = { ":lua require('mood-scripts.command-on-start').restart(false)<CR>", "Kill all servers terminals" },
    S = { ":lua require('mood-scripts.command-on-start').kill_all()<CR>", "TMUX: Kill all servers terminals" },
    q = { ":qall<CR>", "Quit Vim" },
    c = {":cclose<CR>", "Quick Fix Close"},
    d = { ":DiffviewClose<CR>", "Close Diffview" }
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
  if &buftype == 'terminal'
    let win_count = luaeval('require("utils.buf_count")()')

    if win_count <= 1
      if(g:term_as_full_screen_tabs > 0 && tabpagenr() != 1)
        execute "tabclose"
      else
        lua require("utils.goto_last_file_buffer")()
      endif
    else
      if b:common_open == 1
        execute "norm! \<C-w>W"
      else
        try
          execute "close"
        catch /.*/
          call timer_start(10, {-> execute("call HideTerminalWindowOrNoh()") })
        endtry
      endif
    endif
  endif
endfunction

function Maximize()
  if expand('%') != '' && (&buftype != '' || &filetype != '') && &buftype != 'nofile' && &buftype != 'qf' && &buftype != 'quickfix'
    lua require('utils.maximize')()
  else
    execute "norm! \<CR>"
  endif
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

nmap <C-h> :BufSurfBack<CR>
nmap <C-l> :BufSurfForward<CR>

nnoremap <silent> <C-s> :BufferPick<CR>

nnoremap , <C-w>w

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

function Setreg(regname, regval)
  exe "let @".a:regname." = '".a:regval."'"
endfunction

function CopyRelativePath()
  let value = fnamemodify(expand("%"), ":~:.")
  call Setreg("*", value)
  call Setreg("+", value)
  echom "Yanked: " . value
endfunction

function CopyRelativePathWithLine()
  let file = fnamemodify(expand("%"), ":~:.")
  let line = line(".")

  let value = file . ":" . line

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

  call timer_start(500, {-> execute("doautocmd BufNew") })
endfunction

function BetterRename()
  let current_file = expand("%p")
  let current_file_name = expand("%:t")
  let new_name = input("New name for " . current_file_name . ": ", current_file_name)
  let current_folder = expand('%:p:h')

  if(new_name != '' && new_name != current_file_name)
    call feedkeys(":saveas " . current_folder . "/" . new_name . "\<CR>", "n")
    call delete(current_file)
    call feedkeys(":bd! #\<CR>")
    call feedkeys(":e #\<CR>")

    lua require('notify')("File renamed from " .. vim.api.nvim_eval('current_file_name') .. " to " .. vim.api.nvim_eval('new_name'), 'info', { title='File Management' })

    call timer_start(500, {-> execute("doautocmd BufNew") })
  endif
endfunction

function BetterCopy()
  let current_folder = expand('%:p:h')

  call feedkeys(":saveas " . current_folder . "/", 'n')

  call timer_start(500, {-> execute("doautocmd BufNew") })
endfunction

function BetterDelete()
  echo 'Really want to delete current file? y/n '
  let l:answer = nr2char(getchar())

  if l:answer ==? 'y'
    execute "normal! :Delete!\<CR>"
    lua require('notify')("File deleted.", 'info', { title='File Management' })
  elseif l:answer ==? 'n'
    return 0
  else
    echo 'Please enter "y" or "n"'
    return BetterDelete()
  endif
endfunction

nnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"
vnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"

nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

imap <C-l> <Right>
imap <C-a> <C-o>0
imap <C-e> <C-o>-
imap <C-h> <Left>

cnoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

imap <C-p> <Plug>(emmet-expand-abbr)

nmap gF <C-w>f
imap <C-d> <Delete>
cmap <C-d> <Delete>

nmap <C-q> :EnMasse<CR>

nmap <CR> :call Maximize()<CR>

xmap gl <Plug>(EasyAlign)
nmap gl <Plug>(EasyAlign)

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

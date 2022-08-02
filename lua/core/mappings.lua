local M = {}

function M.setup_which_key()
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
  b = {
    name = "+Buffer",
    N = { ":e ~/.nvim-scratch<CR>", "Open Scratch Buffer" },
    f = { ":Telescope buffers only_cwd=true<CR>", "Find Buffers in this project" },
    F = { ":Telescope buffers<CR>", "Find all buffers" },
    n = { ":lua require('harpoon.ui').nav_next()<CR>", "Next Harpoon" },
    p = { ":lua require('harpoon.ui').nav_prev()<CR>", "Prev Harpoon" }
  },
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
  l = { ":lua require('plugins.telescope.custom').terminals()<CR>", "List All Terminals" },
  L = { ":SendHere<CR>", "Mark Terminal to Send Text" },
  h = {
    name = "+Help",
    t = { ":Telescope colorscheme<CR>", "Change Theme" },
    h = { ":e ~/.config/nvim/handbook.md<CR>", "Open the Handbook" },
    u = { ":UpdateMood<CR>", "Update mooD" },
    d = { ":!rm -rf ~/.local/share/nvim/swap/*<CR>", "Delete SWP files" },
    r = { ":LspRestart<CR>", "Restart LSP" },
    T = { ":lua require('tutorial').start()<CR>", "Start Tutorial" }
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
    D = { ":lua require('plugins.telescope.custom').live_grep_in_folder()<CR>", 'Search text in one or more folders' },
    d = { ":lua require('telescope.builtin').live_grep { search_dirs = {vim.fn.expand('%:p:h')}, prompt_title = 'Live grep inside ' .. vim.fn.expand('%:p:h') }<CR>", 'Search text in some folder' },
    p = { ":Telescope live_grep<CR>", "Search text on Project" },
    o = { ":Telescope live_grep grep_open_files=true<CR>", "Search on Open Files" },
    P = { ":lua require('plugins.telescope.custom_telescope').ripgrep()<CR>", "Advanced Search text on Project" },
    f = { ":CtrlSF ", "Search text using CoC (for search and replace)" },
    s = { ":Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>", "Fuzzy Current Buffer" },
    i = { ":Telescope lsp_document_symbols<CR>", "Search Outline Symbols" },
    j = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Symbols" },
    },
  f = {
    name = "+File",
    o = { ":AerialToggle<CR>", "Show Window Symbols" },
    L = { ":e ~/.config/nvim/lua/user/lsp.lua<CR>", "LSP Settings" },
    a = { ":OtherClear<CR>:Other<CR>", "Alternate File" },
    A = { ":OTherClear<CR>:OtherVSplit<CR>", "Alternate File Split" },
    r = { ":Telescope oldfiles<CR>", "Recent Files" },
    s = { ":w!", "Save" },
    R = { ":call BetterRename()<CR>", "Rename Current File" },
    M = { ":call BetterMove()<CR>", "Move Current File" },
    D = { ":call BetterDelete()<CR>", "Delete the current file" },
    p = { ":e ~/.config/nvim/lua/user/config.lua<CR>", "Open Your Private Files" },
    P = { ":e ~/.config/nvim/lua/user/plugins.lua<CR>", "Open Your Plugin" },
    y = { ":call CopyRelativePath()<CR>", "Copy Relative Path" },
    l = { ":call CopyRelativePathWithLine()<CR>", "Copy Path With Line" },
    Y = { ":call CopyFullPath()<CR>", "Copy Full Path" },
    C = { ":call BetterCopy()<CR>", "Copy current file to" }
    },
  m = {
    name = "+Ruby",
    a = { ":RAddParameter<CR>", "Add Parameter" },
    c = { ":call GetClassName()<CR>", "Copy Class Name to Clipboard" },
    d = { ":lua require('mood-scripts.rubocop').comment_rubocop()<CR>", "Comment Rubocop Error" },
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
end

function M.setup_mappings()
  local bufopts = { noremap=true, silent=true }

  vim.keymap.set('n', '<M-l>', '<C-w>l', bufopts)
  vim.keymap.set('n', '<M-h>', '<C-w>h', bufopts)
  vim.keymap.set('n', '<M-k>', '<C-w>k', bufopts)
  vim.keymap.set('n', '<M-j>', '<C-w>j', bufopts)
  vim.keymap.set('n', ';', require("mood-scripts.harpoon-menu"), bufopts)
  vim.keymap.set('n', ']g', ':Gitsigns next_hunk<CR>', bufopts)
  vim.keymap.set('n', '[g', ':Gitsigns prev_hunk<CR>', bufopts)

  vim.keymap.set('n', ']q', ':cnext<CR>')
  vim.keymap.set('n', '[q', ':cprevious<CR>')
  vim.keymap.set('n', '\\', ':wall<CR>')
  vim.keymap.set('n', 'ç', ':wall<CR>')
  vim.keymap.set('n', '-', '$')
  vim.keymap.set('v', '-', '$<Left>')
  vim.keymap.set('n', ',', '<C-w>w')
  vim.keymap.set('n', 'gh', ':SidewaysLeft<cr>')
  vim.keymap.set('n', 'gl', ':SidewaysRight<cr>')
  vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
  vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
  vim.keymap.set('n', '<c-w>c', ':call undoquit#SaveWindowQuitHistory()<cr><c-w>c')
  vim.keymap.set('i', '<C-v>', '<C-r>+')
  vim.keymap.set('c', '<C-v>', '<C-r>+')
  vim.keymap.set('v', '<', '<gv')
  vim.keymap.set('v', '>', '>gv')
  vim.keymap.set('x', 'q', 'iq')
  vim.keymap.set('o', 'q', 'iq')
  vim.keymap.set('o', 'aa', '<Plug>SidewaysArgumentTextobjA')
  vim.keymap.set('x', 'aa', '<Plug>SidewaysArgumentTextobjA')
  vim.keymap.set('o', 'ia', '<Plug>SidewaysArgumentTextobjI')
  vim.keymap.set('x', 'ia', '<Plug>SidewaysArgumentTextobjI')
  vim.keymap.set('i', '<C-l>', '<Right>')
  vim.keymap.set('i', '<C-a>', '<C-o>0')
  vim.keymap.set('i', '<C-e>', '<C-o>-')
  vim.keymap.set('i', '<C-h>', '<Left>')
  vim.keymap.set('c', '<C-l>', '<Right>')
  vim.keymap.set('c', '<C-h>', '<Left>')
  vim.keymap.set('c', '<C-a>', '<Home>')
  vim.keymap.set('c', '<C-e>', '<End>')
  vim.keymap.set('i', '<C-p>', '<Plug>(emmet-expand-abbr)')
  vim.keymap.set('n', 'gF', '<C-w>f')
  vim.keymap.set('i', '<C-d>', '<Delete>')
  vim.keymap.set('c', '<C-d>', '<Delete>')
  vim.keymap.set('n', '<CR>', ':call Maximize()<CR>')
  vim.keymap.set('x', 'gl', '<Plug>(EasyAlign)')

  vim.keymap.set('n', 'H', ':lua require("harpoon.ui").nav_prev()<CR>')
  vim.keymap.set('n', 'L', ':lua require("harpoon.ui").nav_next()<CR>')

  vim.keymap.set('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>')
  vim.keymap.set('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>')
  vim.keymap.set('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>')
  vim.keymap.set('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>')
  vim.keymap.set('n', '<leader>5', ':lua require("harpoon.ui").nav_file(5)<CR>')
  vim.keymap.set('n', '<leader>6', ':lua require("harpoon.ui").nav_file(6)<CR>')
  vim.keymap.set('n', '<leader>7', ':lua require("harpoon.ui").nav_file(7)<CR>')
  vim.keymap.set('n', '<leader>8', ':lua require("harpoon.ui").nav_file(8)<CR>')
  vim.keymap.set('n', '<leader>9', ':lua require("harpoon.ui").nav_file(9)<CR>')

  vim.keymap.set('n', '<C-h>', ':BufSurfBack<CR>')
  vim.keymap.set('n', '<C-l>', ':BufSurfForward<CR>')

  vim.keymap.set('v', '<C-g>', ':<c-u>call SaveSelectionToQuickConsult()<cr>')
  vim.keymap.set('n', '<C-g>', ':<c-u>call OpenConsultationWindow()<cr>')
  vim.keymap.set('t', '<C-g>', ':<c-u>call OpenConsultationWindow()<cr>')

  vim.cmd([[
    nnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"
    vnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"

    nmap vq viq
    nmap dq diq
    nmap yq yiq
    nmap cq ciq
    nmap vij vaI
    nmap vaj vaIj
    nmap dij daI
    nmap daj vaIjd
    nmap cij caI
    nmap caj vaIjc

    nmap <expr> f reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_f" : "f"
    nmap <expr> F reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_F" : "F"
    nmap <expr> t reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_t" : "t"
    nmap <expr> T reg_recording() . reg_executing() == "" ? "<Plug>Lightspeed_T" : "T"

    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
    xnoremap <silent><expr> A mode() ==# "V" ? "<C-v>$A" : "A"
    xnoremap <silent><expr> I mode() ==# "V" ? "<C-v>$^I" : "I"
    xnoremap <silent><expr> i mode() ==# "V" ? "<C-v>$\<Home>I" : "i"

    nmap gq "jyiwmo:,$s/<C-r>=WordForGq()<CR>//gcie\|1,''-&&\|:norm `ozz<c-b><c-e><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
    nmap gQ "jyiwmo:,$S/<C-r>=WordForGq()<CR>//gcie\|1,''-&&\|:norm `ozz<c-b><c-e><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
    xnoremap gq "jymo:,$s/<C-r>=WordForGq()<CR>//gcie\|1,''-&&\|:norm `ozz<c-b><c-e><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>
    xnoremap gQ "jymo:,$S/<C-r>=WordForGq()<CR>//gcie\|1,''-&&\|:norm `ozz<c-b><c-e><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left><left>

  nnoremap <silent><esc> :call HideTerminalWindowOrNoh()<CR>:noh<CR>
  ]])
end

function M.setup()
  vim.g.mapleader = " "

  M.setup_which_key()
  M.setup_mappings()
end

return M

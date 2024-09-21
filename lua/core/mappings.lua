local M = {}
local tmux = require("tmux-awesome-manager")

local function close_all_buffers()
  -- Get a list of all buffer numbers
  local buf_nums = vim.fn.filter(vim.fn.range(1, vim.fn.bufnr("$")), "buflisted(v:val)")

  -- Iterate through the buffer numbers and close them
  for _, buf_num in ipairs(buf_nums) do
    -- Ensure the buffer is not the current buffer
    if vim.fn.bufwinnr(buf_num) == -1 then
      vim.cmd("bdelete " .. buf_num)
    end
  end
end

function M.setup_which_key()
  local wk = require("which-key")

  wk.add(
    {
      mode = { "v" },
      { "<leader>hs",    "<Plug>AutoCalcAppendWithSum",                    desc = "Sum" },
      { "<leader>h?",    "<Plug>AutoCalcAppend",                           desc = "Auto Calculation" },
      { "<leader><C-g>", ":<c-u>call AppendSelectionToQuickConsult()<CR>", desc = "Append Selection" },
      { "<leader>ns",    ":Snake<CR>",                                     desc = "snake_case" },
      { "<leader>nc",    ":Camel<CR>",                                     desc = "CamelCase" },
      { "<leader>nb",    ":CamelB<CR>",                                    desc = "camelCaseB" },
      { "<leader>m",     "<cmd>WhichKey <F-12> v<CR>",                     desc = "+Localleader Mappings" },
      { "<leader>l",     tmux.send_text_to,                                desc = "Send selection to tmux window / pane" },
      { "<leader>ca",    "<cmd>lua vim.lsp.buf.code_action()<CR>",         desc = "Code Action" },
    })

  -- Normal mode:
  wk.add(
    {
      { "<leader>-",     "migg=G'i:w<CR>",                                                                               desc = "Indent Current File" },
      { "<leader>bD",    close_all_buffers,                                                                              desc = "Close All Buffers but visible" },
      { "<leader>bN",    ":e ~/.nvim-scratch<CR>",                                                                       desc = "Open Scratch Buffer" },
      { "<leader>bf",    function() require("mood-scripts.visible_path").prettyBuffersPicker({ only_cwd = true }) end,   desc = "Find Buffers in this project" },
      { "<leader>bF",    function() require("mood-scripts.visible_path").prettyBuffersPicker({}) end,                    desc = "Find all buffers" },
      { "<leader><",     ":Telescope buffers ignore_current_buffer=true sort_mru=true<CR>",                              desc = "Find All Buffers" },
      { "<leader>*",     ":Telescope grep_string<CR>",                                                                   desc = "Search string at point on project" },
      { "<leader> ",     function() require("mood-scripts.custom_telescope").project_files() end,                        desc = "Find Files" },
      { "<leader>e",     ":NvimTreeToggle<CR>",                                                                          desc = "Toggle Tree" },
      { "<leader>E",     ":NvimTreeFindFile<CR>",                                                                        desc = "Toggle Tree Current File" },
      { "<leader>d",     ":call AddDebugger()<CR>",                                                                      desc = "+Debug" },
      { "<leader>D",     ":call ClearDebugger()<CR>",                                                                    desc = "Clear debuggers" },
      { "<leader>u",     ":UndotreeToggle<CR>",                                                                          desc = "Undo Tree" },
      { "<leader>n",     desc = "+Toggle Case" },
      { "<leader>ns",    ":Snake<CR>",                                                                                   desc = "snake_case" },
      { "<leader>nc",    ":Camel<CR>",                                                                                   desc = "camelCase" },
      { "<leader>nb",    ":CamelB<CR>",                                                                                  desc = "CamelCaseB" },
      { "<leader>h",     desc = "+Help" },
      { "<leader>hK",    "<cmd>!rm -rf ~/.local/state/nvim/sessions<CR>",                                                desc = "Delete All Sessions" },
      { "<leader>hl",    ':lua require("persistence").load()<cr>',                                                       desc = "Load Session" },
      { "<leader>hf",    function() vim.g.format_on_save = not vim.g.format_on_save end,                                 desc = "Enable/Disable format on save" },
      { "<leader>ht",    ":Telescope colorscheme<CR>",                                                                   desc = "Change Theme" },
      { "<leader>hh",    ":e ~/.config/nvim/handbook.md<CR>:AerialToggle<CR><C-w>h",                                     desc = "Open the Handbook" },
      { "<leader>hu",    ":UpdateMood<CR>",                                                                              desc = "Update mooD" },
      { "<leader>hd",    ":!rm -rf ~/.local/share/nvim/swap/*<CR>",                                                      desc = "Delete SWP files" },
      { "<leader>hr",    "<cmd>lua require('mood-scripts.restart-lsp').restart_lsp()<CR>",                               desc = "Restart LSP" },
      { "<leader>hm",    ":Mason<CR>",                                                                                   desc = "Mason" },
      { "<leader>hT",    ":lua require('tutorial').start()<CR>",                                                         desc = "Start Tutorial" },
      { "<leader>.",     ":Telescope file_browser path=%:p:h hidden=true respect_gitignore=false<CR>",                   desc = "File Browser" },
      { "<leader>m",     "<cmd>WhichKey <F-12><CR>",                                                                     desc = "+Localleader Mappings" },
      { "<leader>p",     ":Telescope yank_history<CR>",                                                                  desc = "Yank History" },
      { "<leader><C-g>", desc = "+QuickConsult" },
      { "<leader><C-ga", ":call AppendClipboardToQuickConsult()<CR>",                                                    desc = "Append Text From Clipboard to Quick Consult" },
      { "<leader><C-gs", ":call SaveClipboardToQuickConsult()<CR>",                                                      desc = "Save Text From Clipboard to Quick Consult" },
      { "<leader>l",     desc = "+TMUX Terminals" },
      { "<leader>lo",    tmux.switch_orientation, desc = "Switch Orientation" },
      { "<leader>lp",    tmux.switch_open_as, desc = "Switch Open As to Pane / Window" },
      { "<leader>lf",    ":Telescope tmux-awesome-manager list_terms<CR>",                                               desc = "List all Terms" },
      { "<leader>ll",    ":Telescope tmux-awesome-manager list_open_terms<CR>",                                          desc = "List Open Terms" },
      { "<leader>lk",    tmux.kill_all_terms, desc = "Kill all Terms" },
      { "<leader>t",     desc = "+Test" },
      { "<leader>to",    "<cmd>cg /tmp/quickfix.out<CR><cmd>copen<CR><cmd>cfirst<CR>", desc = "Open Quickfix Output" },
      { "<leader>tc",    require("mood-scripts.rspec").clear_diagnostics, desc = "Clear Test Diagnostics" },
      { "<leader>tv",    ":TestFile<CR>",                                                                                desc = "Test Current File" },
      { "<leader>ts",    ":TestNearest<CR>",                                                                             desc = "Test Nearest Test" },
      { "<leader>tb",    require("mood-scripts.rspec").go_to_backtrace, desc = "Go to Backtrace" },
      { "<leader>ta",    ":TestSuite<CR>",                                                                               desc = "Test Project" },
      {
        "<leader>tf",
        function()
          if vim.fn.filereadable("/tmp/quickfix.out") then
            os.remove("/tmp/quickfix.out")
          end
          require("mood-scripts.rspec").clear_diagnostics()
          require("mood-scripts.rspec").wait_quickfix_to_insert_diagnostics()
          local neovim_file_path = vim.fn.stdpath("config")
          vim.cmd("RSpec " ..
            "--require=" ..
            neovim_file_path ..
            "/helpers/vim_formatter.rb --format VimFormatter --out /tmp/quickfix.out --format progress --only-failures")
        end,
        desc = "Test Only Failed Tests"
      },
      { "<leader>tr",  ":TestLast<CR>",                                                         desc = "Rerun Last Test" },
      { "<leader>c",   desc = "+Lsp" },
      { "<leader>cw",  desc = "+Workspace" },
      { "<leader>cwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",                       desc = "Add Workspace" },
      { "<leader>cwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",                    desc = "Remove Workspace" },
      { "<leader>cwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", desc = "List Workspaces" },
      { "<leader>cx",  ":Telescope diagnostics<CR>",                                            desc = "Diagnostics" },
      { "<leader>cX",  ":Telescope diagnostics<CR>",                                            desc = "Diagnostics" },
      { "<leader>cr",  "<cmd>lua vim.lsp.buf.rename()<CR>",                                     desc = "Rename" },
      { "<leader>ca",  "<cmd>lua vim.lsp.buf.code_action()<CR>",                                desc = "Code Action" },
      { "<leader>cf",  "<cmd>FormatWrite<CR>",                                                  desc = "Format" },
      {
        "<leader>ci",
        function()
          require("mood-scripts.visible_path").prettyDocumentSymbols({})
        end,
        desc = "Document Symbols"
      },
      {
        "<leader>cj",
        function()
          require("mood-scripts.visible_path").prettyWorkspaceSymbols({})
        end,
        desc = "Workspace Symbols"
      },
      { "<leader><return>", ":Telescope resume<CR>",                                                                               desc = "Telescope Resume" },
      { "<leader>s",        desc = "+Search" },
      { "<leader>sD",       ":lua require('mood-scripts.custom_telescope').live_grep_in_folder({ respect_gitignore = true })<CR>", desc = "Search text in one or more folders" },
      {
        "<leader>sd",
        function()
          require("telescope").extensions.egrepify.egrepify({
            additional_args = "-j1",
            search_dirs = { vim.fn.fnamemodify(vim.fn.expand("%:~:h"), ":.") },
            layout_strategy = require("mood-scripts.layout_strategy").grep_layout(),
          })
        end,
        desc = "Search text in some folder"
      },
      {
        "<leader>sp",
        function()
          require("telescope").extensions.egrepify.egrepify({
            additional_args = "-j1",
            layout_strategy = require("mood-scripts.layout_strategy").grep_layout(),
          })
        end,
        desc = "Search text on Project"
      },
      { "<leader>so", ":Telescope egrepify grep_open_files=true<CR>",                desc = "Search on Open Files" },
      { "<leader>P",  ":lua require('mood-scripts.custom_telescope').ripgrep()<CR>", desc = "Advanced Search text on Project" },
      { "<leader>sf", ":CtrlSF ",                                                    desc = "Search text using CtrlSF (for search and replace)" },
      {
        "<leader>si",
        function()
          require("mood-scripts.visible_path").prettyDocumentSymbols({})
        end,
        desc = "Search Outline Symbols"
      },
      {
        "<leader>sj",
        function()
          require("mood-scripts.visible_path").prettyWorkspaceSymbols({})
        end,
        desc = "Symbols"
      },
      { "<leader>f",  desc = "+File" },
      { "<leader>fo", ":AerialToggle<CR>",                                             desc = "Show Window Symbols" },
      { "<leader>fa", ":lua require('telescope-alternate.telescope').alternate()<CR>", desc = "Alternate File" },
      {
        "<leader>fr",
        function()
          require("mood-scripts.visible_path").prettyFilesPicker({ picker = "oldfiles" })
        end,
        desc = "Recent Files"
      },
      {
        "<leader>fF",
        function()
          require("mood-scripts.visible_path").prettyFilesPicker({ picker = "find_files" })
        end,
        desc = "Find Files"
      },
      { "<leader>fR", ":call BetterRename()<CR>", desc = "Rename Current File" },
      { "<leader>fM", ":call BetterMove()<CR>",   desc = "Move Current File" },
      { "<leader>fD", ":call BetterDelete()<CR>", desc = "Delete the current file" },
      {
        "<leader>fp",
        function()
          require("mood-scripts.open-files").open_dotfiles()
        end,
        desc = "User Mood Files"
      },
      { "<leader>fy", ":call CopyRelativePath()<CR>",                                                 desc = "Copy Relative Path" },
      { "<leader>fl", ":call CopyRelativePathWithLine()<CR>",                                         desc = "Copy Path With Line" },
      { "<leader>fY", ":call CopyFullPath()<CR>",                                                     desc = "Copy Full Path" },
      { "<leader>fC", ":call BetterCopy()<CR>",                                                       desc = "Copy current file to" },
      { "<leader>#",  tmux.run_project_terms,                                                         desc = "Execute / Re-excute project terminals" },
      { "<leader>%",  ":lua require('mood-scripts.command-on-start').restart_all()<CR>",              desc = "TMUX: Execute / Re-execute project terminal all" },
      { "<leader>g",  desc = "+Git" },
      { "<leader>gg", ":LazyGit<CR>",                                                                 desc = "LazyGit" },
      { "<leader>gt", ":lua require('agitator').git_time_machine()<CR>",                              desc = "Git Time Machine" },
      { "<leader>gT", ":DiffviewFileHistory %<CR>:echo 'Use SPC q d or :DiffviewClose to quit.'<CR>", desc = "File History" },
      { "<leader>gr", ":Gitsigns reset_hunk<CR>",                                                     desc = "Reset hunk at point" },
      { "<leader>gc", ":Gdiff<CR>",                                                                   desc = "Diff from HEAD" },
      { "<leader>gs", ":Gitsigns stage_hunk<CR>",                                                     desc = "Stage hunk at point" },
      { "<leader>gS", ":Gitsigns stage_buffer<CR>",                                                   desc = "Stage buffer" },
      { "<leader>gR", ":Gitsigns reset_buffer<CR>",                                                   desc = "Reset buffer" },
      { "<leader>gp", ":Gitsigns preview_hunk<CR>",                                                   desc = "Preview Hunk" },
      { "<leader>gb", ":Git blame<CR>",                                                               desc = "Blame" },
      { "<leader>gd", ":DiffviewOpen<CR>:echo 'Use SPC q d or :DiffviewClose to quit.'<CR>",          desc = "Git Diff" },
      { "<leader>gl", ":Git log -p %<CR>",                                                            desc = "Git log -p on file" },
      { "<leader>gL", ":DiffviewFileHistory<CR>:echo 'Use SPC q d or :DiffviewClose to quit.'<CR>",   desc = "Log Commits" },
      { "<leader>gB", ":Telescope git_branches<CR>",                                                  desc = "Change Branch" },
      {
        "<leader>,",
        function()
          require("mood-scripts.visible_path").prettyBuffersPicker({
            only_cwd = true,
            ignore_current_buffer = true,
            sort_mru = true,
          })
        end,
        desc = "Find Buffers in this project"
      },
      { "<leader><tab>", ":Telescope git_status<CR>",                        desc = "Git Modified Files" },
      { "<leader>w",     desc = "+Window" },
      { "<leader>ww",    "<C-w>w",                                           desc = "Next Window" },
      { "<leader>wW",    "<C-w>W",                                           desc = "Previous Windows" },
      { "<leader>wo",    "<C-w>o",                                           desc = "Maximize Window" },
      { "<leader>wu",    "<C-w>u",                                           desc = "Restore killed window" },
      { "<leader>wc",    ":call undoquit#SaveWindowQuitHistory()<cr><c-w>c", desc = "Close Window" },
      { "<leader>wq",    ":call undoquit#SaveWindowQuitHistory()<cr><c-w>c", desc = "Kill Window" },
      { "<leader>wx",    "<C-w>x",                                           desc = "Swap windows" },
      { "<leader>wv",    "<C-w>v",                                           desc = "Split Vertical" },
      { "<leader>ws",    "<C-w>s",                                           desc = "Split Horizontal" },
      { "<leader>wm",    require("utils.maximize"),                          desc = "Maximize Window" },
      { "<leader>q",     desc = "+Quit and Close" },
      { "<leader>qq",    ":qall<CR>",                                        desc = "Quit Vim" },
      { "<leader>qc",    ":cclose<CR>",                                      desc = "Quick Fix Close" },
      { "<leader>qd",    ":DiffviewClose<CR>",                               desc = "Close Diffview" },
    }
  )
end

function M.setup_mappings()
  local bufopts = { noremap = true, silent = true }

  local set = vim.keymap.set

  set("n", "<M-l>", "<C-w>l", bufopts)
  set("n", "H", require("arrow.persist").previous)
  set("n", "L", require("arrow.persist").next)
  set("n", "<M-h>", "<C-w>h", bufopts)
  set("n", "<M-k>", "<C-w>k", bufopts)
  set("n", "<M-j>", "<C-w>j", bufopts)
  set("n", "]g", ":Gitsigns next_hunk<CR>", bufopts)
  set("n", "[g", ":Gitsigns prev_hunk<CR>", bufopts)
  set("n", "yb", ":%y+<CR>", bufopts)
  set("n", "ge", "`", { noremap = true })

  set("n", "<Esc>", ":noh<CR><esc>", bufopts)

  set("t", "<C-g>", "<C-\\><C-n>")
  set("t", "<C-v>", "<C-\\><C-N>pi")

  set("n", "]q", ":cnext<CR>")
  set("n", "[q", ":cprevious<CR>")
  set("n", "ç", ":wall<CR>")
  set("n", "\\", ":wall<CR>")
  set("n", "-", "$")
  set("x", "-", "$<Left>")
  set("n", ",", "<C-w>W")
  set("n", "gh", ":SidewaysLeft<cr>")
  set("n", "gl", ":SidewaysRight<cr>")
  set("x", "J", ":m '>+1<CR>gv=gv")
  set("x", "K", ":m '<-2<CR>gv=gv")
  set("n", "<c-w>c", ":call undoquit#SaveWindowQuitHistory()<cr><c-w>c")
  set("i", "<C-v>", "<C-r>+")
  set("c", "<C-v>", "<C-r>+")
  set("x", "<", "<gv")
  set("x", ">", ">gv")
  set("x", "q", "iq")
  set("o", "q", "iq")
  set("o", "aa", "<Plug>SidewaysArgumentTextobjA")
  set("x", "aa", "<Plug>SidewaysArgumentTextobjA")
  set("o", "ia", "<Plug>SidewaysArgumentTextobjI")
  set("x", "ia", "<Plug>SidewaysArgumentTextobjI")
  set("i", "<C-l>", "<Right>")
  set("i", "<C-a>", "<C-o>0")
  set("i", "<C-h>", "<Left>")
  set("n", "<C-h>", "<cmd>b#<CR>")
  set("c", "<C-l>", "<Right>")
  set("c", "<C-h>", "<Left>")
  set("c", "<C-a>", "<Home>")
  set("c", "<C-e>", "<End>")
  set("c", "<C-j>", "<C-left>")
  set("c", "<C-k>", "<C-right>")
  set("i", "<C-p>", "<Plug>(emmet-expand-abbr)")
  set("n", "gF", "<C-w>f")
  set("i", "<C-d>", "<Delete>")
  set("c", "<C-d>", "<Delete>")

  set("n", "<C-s>", require("arrow.persist").toggle)

  set("x", "<C-g>", ":<c-u>call SaveSelectionToQuickConsult()<cr>")
  set("n", "<C-g>", ":<c-u>call OpenConsultationWindow()<cr>")

  local tmux_win = require("mood-scripts.tmux-integration")

  set({ "n", "v" }, "]a", "<cmd>SidewaysJumpRight<CR>")
  set({ "n", "v" }, "[a", "<cmd>SidewaysJumpLeft<CR>")

  set({ "n", "x" }, "<C-w>;", tmux_win.go_to_next, {})
  set({ "n", "x" }, "<C-w>,", tmux_win.go_to_prev, {})

  set("n", "]d", vim.diagnostic.goto_next)
  set("n", "[d", vim.diagnostic.goto_prev)

  vim.cmd([[
    nnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"
    vnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"

    nmap vq viq
    nmap dq diq
    nmap yq yiq
    nmap cq ciq
    nmap vij vaI
    nmap vai vaI
    nmap vaj vaIj
    nmap dij daI
    nmap daI daI
    nmap daj vaIjd
    nmap cij caI
    nmap caj vaI
    nmap cai caI

    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
    xnoremap <silent><expr> A mode() ==# "V" ? "<C-v>$A" : "A"
    xnoremap <silent><expr> I mode() ==# "V" ? "<C-v>$^I" : "I"
    xnoremap <silent><expr> i mode() ==# "V" ? "<C-v>$\<Home>I" : "i"
  ]])
end

function M.ruby()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "ruby" },
    callback = function(buf)
      local wk = require("which-key")

      wk.add({
        mode = { "n" },
        buffer = buf.buf,
        { "<leader>m",  desc = "Ruby" },
        { "<leader>mc", ":call GetClassName()<CR>",                                         desc = "Copy Class Name to Clipboard" },
        { "<leader>mC", ":call SearchClassName()<CR>",                                      desc = "Search current class on project" },
        { "<leader>md", ":lua require('mood-scripts.rubocop').comment_rubocop()<CR>",       desc = "Comment Rubocop Error" },
        { "<leader>mf", "<cmd>lua require('ruby-toolkit').create_function_from_text()<CR>", desc = "Create Function from item on cursor" },
      })

      wk.add({
        mode = { "n" },
        buffer = buf.buf,
        { "<leader>A", ":call OpenTestAlternateAndSplit()<CR>", desc = "Go to Test (split)" },
        { "<leader>a", ":call OpenTestAlternate()<CR>",         desc = "Go to Test" },
      })

      wk.add({
        mode = "v",
        buffer = buf.buf,
        { "<leader>m",  desc = "Ruby" },
        { "<leader>mv", "<cmd>lua require('ruby-toolkit').extract_variable()<CR>",    desc = "Extract Variable" },
        { "<leader>mf", "<cmd>lua require('ruby-toolkit').extract_to_function()<CR>", desc = "Extract To Function" },
      })
    end,
  })
end

function M.setup()
  M.setup_which_key()
  M.setup_mappings()
  M.ruby()
end

return M

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
			b = { ":CamelB<CR>", "camelCaseB" },
		},
		m = { "<cmd>WhichKey <F-12> v<CR>", "+Localleader Mappings" },
		l = {
			tmux.send_text_to,
			"Send selection to tmux window / pane",
		},
		c = {
			name = "+Lsp",
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
		},
	}, { mode = "v", prefix = "<leader>" })

	-- Normal mode:
	wk.register({
		["-"] = { "migg=G'i:w<CR>", "Indent Current File" },
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
			D = {
				close_all_buffers,
				"Close All Buffers but visible",
			},
			N = { ":e ~/.nvim-scratch<CR>", "Open Scratch Buffer" },
			f = {
				function()
					require("mood-scripts.visible_path").prettyBuffersPicker({ only_cwd = true })
				end,
				"Find Buffers in this project",
			},
			F = {
				function()
					require("mood-scripts.visible_path").prettyBuffersPicker({})
				end,
				"Find all buffers",
			},
		},
		["<"] = { ":Telescope buffers ignore_current_buffer=true sort_mru=true<CR>", "Find All Buffers" },
		["*"] = { ":Telescope grep_string<CR>", "Search string at point on project" },
		["<space>"] = {
			function()
				require("mood-scripts.custom_telescope").project_files()
			end,
			"Find Files",
		},
		e = { ":NvimTreeToggle<CR>", "Toggle Tree" },
		E = { ":NvimTreeFindFile<CR>", "Toggle Tree Current File" },
		d = { ":call AddDebugger()<CR>", "+Debug" },
		D = { ":call ClearDebugger()<CR>", "Clear debuggers" },
		u = { ":UndotreeToggle<CR>", "Undo Tree" },
		n = {
			name = "+Toggle Case",
			s = { ":Snake<CR>", "snake_case" },
			c = { ":Camel<CR>", "camelCase" },
			b = { ":CamelB<CR>", "CamelCaseB" },
		},
		h = {
			name = "+Help",
			K = { "<cmd>!rm -rf ~/.local/state/nvim/sessions<CR>", "Delete All Sessions" },
			l = { ':lua require("persistence").load()<cr>', "Load Session" },
			f = {
				function()
					vim.g.disable_format_on_save = not vim.g.disable_format_on_save
				end,
				"Enable/Disable format on save",
			},
			t = { ":Telescope colorscheme<CR>", "Change Theme" },
			h = { ":e ~/.config/nvim/handbook.md<CR>:AerialToggle<CR><C-w>h", "Open the Handbook" },
			u = { ":UpdateMood<CR>", "Update mooD" },
			d = { ":!rm -rf ~/.local/share/nvim/swap/*<CR>", "Delete SWP files" },
			r = { "<cmd>lua require('mood-scripts.restart-lsp').restart_lsp()<CR>", "Restart LSP" },
			m = { ":Mason<CR>", "Mason" },
			T = { ":lua require('tutorial').start()<CR>", "Start Tutorial" },
		},
		["."] = { ":Telescope file_browser path=%:p:h hidden=true respect_gitignore=false<CR>", "File Browser" },
		m = { "<cmd>WhichKey <F-12><CR>", "+Localleader Mappings" },
		p = { ":Telescope yank_history<CR>", "Yank History" },
		["<C-g>"] = {
			name = "+QuickConsult",
			a = { ":call AppendClipboardToQuickConsult()<CR>", "Append Text From Clipboard to Quick Consult" },
			s = { ":call SaveClipboardToQuickConsult()<CR>", "Save Text From Clipboard to Quick Consult" },
		},
		l = {
			name = "+TMUX Terminals",
			o = { tmux.switch_orientation, "Switch Orientation" },
			p = { tmux.switch_open_as, "Switch Open As to Pane / Window" },
			f = { ":Telescope tmux-awesome-manager list_terms<CR>", "List all Terms" },
			l = { ":Telescope tmux-awesome-manager list_open_terms<CR>", "List Open Terms" },
			k = { tmux.kill_all_terms, "Kill all Terms" },
		},
		t = {
			name = "+Test",
			o = { "<cmd>cg /tmp/quickfix.out<CR><cmd>copen<CR><cmd>cfirst<CR>", "Open Quickfix Output" },
			c = { require("mood-scripts.rspec").clear_diagnostics, "Clear Test Diagnostics" },
			v = { ":TestFile<CR>", "Test Current File" },
			s = { ":TestNearest<CR>", "Test Nearest Test" },
			b = { require("mood-scripts.rspec").go_to_backtrace, "Go to Backtrace" },
			a = { ":TestSuite<CR>", "Test Project" },
			f = {
				function()
					if vim.fn.filereadable("/tmp/quickfix.out") then
						os.remove("/tmp/quickfix.out")
					end

					require("mood-scripts.rspec").clear_diagnostics()
					require("mood-scripts.rspec").wait_quickfix_to_insert_diagnostics()

					local neovim_file_path = vim.fn.stdpath("config")
					vim.cmd(
						"RSpec "
							.. "--require="
							.. neovim_file_path
							.. "/helpers/vim_formatter.rb --format VimFormatter --out /tmp/quickfix.out --format progress --only-failures"
					)
				end,
				"Test Only Failed Tests",
			},
			r = { ":TestLast<CR>", "Rerun Last Test" },
		},
		c = {
			name = "+Lsp",
			w = {
				name = "+Workspace",
				a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace" },
				r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace" },
				l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspaces" },
			},
			x = { ":Telescope diagnostics<CR>", "Diagnostics" },
			X = { ":Telescope diagnostics<CR>", "Diagnostics" },
			r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			f = { "<cmd>FormatWrite<CR>", "Format" },
			i = {
				function()
					require("mood-scripts.visible_path").prettyDocumentSymbols({})
				end,
				"Document Symbols",
			},
			j = {
				function()
					require("mood-scripts.visible_path").prettyWorkspaceSymbols({})
				end,
				"Workspace Symbols",
			},
		},
		["<return>"] = { ":Telescope resume<CR>", "Telescope Resume" },
		s = {
			name = "+Search",
			D = {
				":lua require('mood-scripts.custom_telescope').live_grep_in_folder({ respect_gitignore = true })<CR>",
				"Search text in one or more folders",
			},
			d = {
				function()
					require("telescope").extensions.egrepify.egrepify({
						additional_args = "-j1",
						search_dirs = { vim.fn.fnamemodify(vim.fn.expand("%:~:h"), ":.") },
						layout_strategy = require("mood-scripts.layout_strategy").grep_layout(),
					})
				end,
				"Search text in some folder",
			},
			p = {
				function()
					require("telescope").extensions.egrepify.egrepify({
						additional_args = "-j1",
						layout_strategy = require("mood-scripts.layout_strategy").grep_layout(),
					})
				end,
				"Search text on Project",
			},
			o = { ":Telescope egrepify grep_open_files=true<CR>", "Search on Open Files" },
			P = { ":lua require('mood-scripts.custom_telescope').ripgrep()<CR>", "Advanced Search text on Project" },
			f = { ":CtrlSF ", "Search text using CtrlSF (for search and replace)" },
			s = { ":Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<CR>", "Fuzzy Current Buffer" },
			i = {
				function()
					require("mood-scripts.visible_path").prettyDocumentSymbols({})
				end,
				"Search Outline Symbols",
			},
			j = {
				function()
					require("mood-scripts.visible_path").prettyWorkspaceSymbols({})
				end,
				"Symbols",
			},
		},
		f = {
			name = "+File",
			o = { ":AerialToggle<CR>", "Show Window Symbols" },
			a = { ":lua require('telescope-alternate.telescope').alternate()<CR>", "Alternate File" },
			r = {
				function()
					require("mood-scripts.visible_path").prettyFilesPicker({ picker = "oldfiles" })
				end,
				"Recent Files",
			},
			f = {
				function()
					require("mood-scripts.visible_path").prettyFilesPicker({ picker = "find_files" })
				end,
				"Find Files",
			},
			R = { ":call BetterRename()<CR>", "Rename Current File" },
			M = { ":call BetterMove()<CR>", "Move Current File" },
			D = { ":call BetterDelete()<CR>", "Delete the current file" },
			p = {
				function()
					require("mood-scripts.open-files").open_dotfiles()
				end,
				"User Mood Files",
			},
			y = { ":call CopyRelativePath()<CR>", "Copy Relative Path" },
			l = { ":call CopyRelativePathWithLine()<CR>", "Copy Path With Line" },
			Y = { ":call CopyFullPath()<CR>", "Copy Full Path" },
			C = { ":call BetterCopy()<CR>", "Copy current file to" },
		},
		["#"] = { tmux.run_project_terms, "Execute / Re-excute project terminals" },
		["%"] = {
			":lua require('mood-scripts.command-on-start').restart_all()<CR>",
			"TMUX: Execute / Re-execute project terminal all",
		},
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
			b = { ":Git blame<CR>", "Blame" },
			d = { ":DiffviewOpen<CR>:echo 'Use SPC q d or :DiffviewClose to quit.'<CR>", "Git Diff" },
			l = { ":Git log -p %<CR>", "Git log -p on file" },
			L = { ":DiffviewFileHistory<CR>:echo 'Use SPC q d or :DiffviewClose to quit.'<CR>", "Log Commits" },
			B = { ":Telescope git_branches<CR>", "Change Branch" },
		},
		[","] = {
			function()
				require("mood-scripts.visible_path").prettyBuffersPicker({
					only_cwd = true,
					ignore_current_buffer = true,
					sort_mru = true,
				})
			end,
			"Find Buffers in this project",
		},
		["<tab>"] = { ":Telescope git_status<CR>", "Git Modified Files" },
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
			s = { "<C-w>s", "Split Horizontal" },
			m = { require("utils.maximize"), "Maximize Window" },
		},
		q = {
			name = "+Quit and Close",
			q = { ":qall<CR>", "Quit Vim" },
			c = { ":cclose<CR>", "Quick Fix Close" },
			d = { ":DiffviewClose<CR>", "Close Diffview" },
		},
	}, { prefix = "<leader>", silent = true })
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

function M.typescript()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "typescript", "typescriptreact", "vue" },
		callback = function(buf)
			local wk = require("which-key")
			wk.register({
				["<F-12>"] = {
					name = "+typescript",
					i = { ":TypescriptAddMissingImports<CR>", "Add Missing Imports" },
					o = { ":TypescriptOrganizeImports<CR>", "Organize Imports" },
					u = { ":TypescriptRemoveUnused<CR>", "Remove Unused" },
					r = { ":TypescriptRenameFile<CR>", "Rename File" },
				},
			}, {
				mode = "n",
				buffer = buf.buf,
			})
		end,
	})
end

function M.ruby()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "ruby" },
		callback = function(buf)
			local wk = require("which-key")

			wk.register({
				["<F-12>"] = {
					name = "+ruby",
					c = { ":call GetClassName()<CR>", "Copy Class Name to Clipboard" },
					C = { ":call SearchClassName()<CR>", "Search current class on project" },
					d = { ":lua require('mood-scripts.rubocop').comment_rubocop()<CR>", "Comment Rubocop Error" },
					f = {
						"<cmd>lua require('ruby-toolkit').create_function_from_text()<CR>",
						"Create Function from item on cursor",
					},
				},
			}, {
				mode = "n",
				buffer = buf.buf,
			})

			wk.register({
				A = { ":call OpenTestAlternateAndSplit()<cr>", "Go to Test (split)" },
				a = { ":call OpenTestAlternate()<cr>", "Go to Test" },
			}, {
				mode = "n",
				prefix = "<leader>",
				buffer = buf.buf,
			})

			wk.register({
				["<F-12>"] = {
					name = "+ruby",
					v = { "<cmd>lua require('ruby-toolkit').extract_variable()<CR>", "Extract Variable" },
					f = { "<cmd>lua require('ruby-toolkit').extract_to_function()<CR>", "Extract To Function" },
				},
			}, {
				mode = "v",
				buffer = buf.buf,
			})
		end,
	})
end

function M.setup()
	M.setup_which_key()
	M.setup_mappings()
	M.typescript()
	M.ruby()
end

return M

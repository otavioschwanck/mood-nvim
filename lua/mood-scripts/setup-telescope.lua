local M = {}

function M.setup()
	local _, actions = pcall(require, "telescope.actions")

	local fb_actions = require("telescope").extensions.file_browser.actions
	local mapping = require("yanky.telescope.mapping")

	local winwidth = vim.fn.winwidth(0)

	local vertical_search

	if winwidth < 250 then
		vertical_search = {
			layout_strategy = "vertical",
			layout_config = { preview_cutoff = 10, height = 0.90, width = 0.95 },
		}
	else
		vertical_search = {
			layout_strategy = "horizontal",
		}
	end

	local ternary = function(cond, T, F)
		if cond then
			return T
		else
			return F
		end
	end

	require("telescope").setup({
		defaults = {
			prompt_prefix = " ",
			file_ignore_patterns = vim.g.folder_to_ignore,
			borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			layout_config = ternary(winwidth < 250, { preview_cutoff = 10, height = 0.90, width = 0.95 }, nil),
			mappings = {
				i = {
					["<C-e>"] = function(picker)
						actions.send_selected_to_qflist(picker)
						vim.cmd("copen")
					end,
				},
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			buffers = {
				path_display = require("utils.buffer_path_display"),
				layout_config = { preview_cutoff = 10, width = 0.92 },
			},
			live_grep = vertical_search,
			grep_string = vertical_search,
			diagnostics = vertical_search,
			current_buffer_fuzzy_find = vertical_search,
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = false,
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
			file_browser = {
				hidden = true,
				prompt_path = true,
				mappings = {
					["i"] = {
						["<C-o>"] = fb_actions.remove,
						["<C-y>"] = fb_actions.copy,
						["<C-e>"] = fb_actions.move,
						["<C-space>"] = fb_actions.create_from_prompt,
						["<C-r>"] = fb_actions.rename,
						["<C-c>"] = fb_actions.goto_parent_dir,
						["<C-g>"] = fb_actions.goto_cwd,
						["<C-w>"] = function()
							vim.cmd("normal vbd")
						end,
					},
					["n"] = {
						["<C-o>"] = fb_actions.remove,
						["<C-y>"] = fb_actions.copy,
						["<C-e>"] = fb_actions.move,
						["<C-space>"] = fb_actions.create_from_prompt,
						["<C-r>"] = fb_actions.rename,
						["<C-c>"] = fb_actions.goto_parent_dir,
					},
				},
			},
		},
	})

	require("telescope").load_extension("yank_history")
	require("telescope").load_extension("ui-select")
	require("telescope").load_extension("file_browser")
	require("telescope").load_extension("telescope-alternate")
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("tmux-awesome-manager")
	require("telescope").load_extension("harpoon")
end

return M

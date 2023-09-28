local M = {}

local Layout = require("nui.layout")
local Popup = require("nui.popup")

local telescope = require("telescope")
local TSLayout = require("telescope.pickers.layout")

function M.setup()
	local _, actions = pcall(require, "telescope.actions")

	local fb_actions = require("telescope").extensions.file_browser.actions
	local mapping = require("yanky.telescope.mapping")

	local winwidth = vim.fn.winwidth(0)

	local ternary = function(cond, T, F)
		if cond then
			return T
		else
			return F
		end
	end

	require("telescope").setup({
		defaults = {
			create_layout = function(picker)
				local border = {
					results = {
						top_left = "┌",
						top = "─",
						top_right = "┬",
						right = "│",
						bottom_right = "",
						bottom = "",
						bottom_left = "",
						left = "│",
					},
					results_patch = {
						minimal = {
							top_left = "┌",
							top_right = "┐",
						},
						horizontal = {
							top_left = "┌",
							top_right = "┬",
						},
						vertical = {
							top_left = "├",
							top_right = "┤",
						},
					},
					prompt = {
						top_left = "├",
						top = "─",
						top_right = "┤",
						right = "│",
						bottom_right = "┘",
						bottom = "─",
						bottom_left = "└",
						left = "│",
					},
					prompt_patch = {
						minimal = {
							bottom_right = "┘",
						},
						horizontal = {
							bottom_right = "┴",
						},
						vertical = {
							bottom_right = "┘",
						},
					},
					preview = {
						top_left = "┌",
						top = "─",
						top_right = "┐",
						right = "│",
						bottom_right = "┘",
						bottom = "─",
						bottom_left = "└",
						left = "│",
					},
					preview_patch = {
						minimal = {},
						horizontal = {
							bottom = "─",
							bottom_left = "",
							bottom_right = "┘",
							left = "",
							top_left = "",
						},
						vertical = {
							bottom = "",
							bottom_left = "",
							bottom_right = "",
							left = "│",
							top_left = "┌",
						},
					},
				}

				local results = Popup({
					focusable = false,
					border = {
						style = border.results,
						text = {
							top = picker.prompt_title,
							top_align = "center",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal",
					},
				})

				local prompt = Popup({
					enter = true,
					border = {
						style = border.prompt,
						text = {
							top_align = "center",
						},
					},
					win_options = {
						winhighlight = "Normal:Normal",
					},
				})

				local preview = Popup({
					focusable = false,
					border = {
						style = border.preview,
						text = {
							top_align = "center",
						},
					},
				})

				local box_by_kind = {
					vertical = Layout.Box({
						Layout.Box(preview, { grow = 1 }),
						Layout.Box(results, { grow = 1 }),
						Layout.Box(prompt, { size = 3 }),
					}, { dir = "col" }),
					horizontal = Layout.Box({
						Layout.Box({
							Layout.Box(results, { grow = 1 }),
							Layout.Box(prompt, { size = 3 }),
						}, { dir = "col", size = "50%" }),
						Layout.Box(preview, { size = "50%" }),
					}, { dir = "row" }),
					minimal = Layout.Box({
						Layout.Box(results, { grow = 1 }),
						Layout.Box(prompt, { size = 3 }),
					}, { dir = "col" }),
				}

				local height, width = vim.o.lines, vim.o.columns
				local function get_box()
					local box_kind = "horizontal"
					if width < 150 or (picker.prompt_title == "Live Grep" and width < 300) then
						box_kind = "vertical"
						if height < 30 then
							box_kind = "minimal"
						end
					elseif width < 120 then
						box_kind = "minimal"
					end
					return box_by_kind[box_kind], box_kind
				end

				local function prepare_layout_parts(layout, box_type)
					layout.results = TSLayout.Window(results)
					results.border:set_style(border.results_patch[box_type])

					layout.prompt = TSLayout.Window(prompt)
					prompt.border:set_style(border.prompt_patch[box_type])

					if box_type == "minimal" then
						layout.preview = nil
					else
						layout.preview = TSLayout.Window(preview)
						preview.border:set_style(border.preview_patch[box_type])
					end
				end

				local total_width
				local total_height

				if width < 200 then
					total_width = "90%"
				else
					total_width = "80%"
				end

				local box, box_kind = get_box()

				if box_kind == "vertical" then
					total_height = "90%"
				else
					total_height = "80%"
				end

				local layout = Layout({
					relative = "editor",
					position = "50%",
					size = {
						height = total_height,
						width = total_width,
					},
				}, box)

				layout.picker = picker
				prepare_layout_parts(layout, box_kind)

				local layout_update = layout.update
				function layout:update()
					local box, box_kind = get_box()
					prepare_layout_parts(layout, box_kind)
					layout_update(self, box)
				end

				return TSLayout(layout)
			end,
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
			},
			git_files = {
				show_untracked = true,
			},
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = false,
				override_file_sorter = true,
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
			},
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
			file_browser = {
				hidden = true,
				prompt_path = true,
				hide_parent_dir = true,
				mappings = {
					["i"] = {
						["<C-d>"] = fb_actions.remove,
						["<C-v>"] = fb_actions.copy,
						["<C-x>"] = fb_actions.move,
						["<C-space>"] = fb_actions.create_from_prompt,
						["<C-r>"] = fb_actions.rename,
						["<C-b>"] = fb_actions.goto_cwd,
						["<C-w>"] = function()
							vim.cmd("normal vbd")
						end,
					},
					["n"] = {
						["<C-d>"] = fb_actions.remove,
						["<C-v>"] = fb_actions.copy,
						["<C-x>"] = fb_actions.move,
						["<C-space>"] = fb_actions.create_from_prompt,
						["<C-r>"] = fb_actions.rename,
						["<C-b>"] = fb_actions.goto_cwd,
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

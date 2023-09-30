local Layout = require("nui.layout")
local TSLayout = require("telescope.pickers.layout")
local Popup = require("nui.popup")

local function layout(picker)
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

		if picker.layout_strategy == "center" then
			box_kind = "minimal"
		elseif width < 150 or (picker.prompt_title == "Live Grep" and width < 300) then
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

	if picker.layout_strategy == "center" then
		total_width = "30%"
	elseif width < 200 then
		total_width = "90%"
	elseif width < 400 and picker.prompt_title == "Live Grep" then
		total_width = "90%"
	else
		total_width = "80%"
	end

	local box, box_kind = get_box()

	if picker.layout_strategy == "center" then
		total_height = "30%"
	elseif box_kind == "vertical" then
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
end

return layout

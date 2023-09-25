local buffer_path_display = function(opts, path)
	local tail = require("telescope.utils").path_tail(path)
	local split = require("utils.table_functions").Split

	local splitted_tail = split(path, "/")

	local path_name = ""

	if #splitted_tail >= 2 then
		for i = 1, #splitted_tail - 1, 1 do
			if i < #splitted_tail - 1 then
				path_name = path_name .. "/" .. splitted_tail[i]
			else
				path_name = path_name .. "/" .. splitted_tail[i]
			end
		end
	else
		path_name = "/"
	end

	-- get all buffer names of current cwd
	local buffers = vim.api.nvim_list_bufs()
	local buffer_names = {}
	for _, buffer in pairs(buffers) do
		-- insert buffer name only filename no path
		table.insert(buffer_names, require("telescope.utils").path_tail(vim.api.nvim_buf_get_name(buffer)))
	end

	local max_width = 0

	for _, buffer_name in pairs(buffer_names) do
		local width = #buffer_name
		if width > max_width then
			max_width = width
		end
	end

	local displayer = require("telescope.pickers.entry_display").create({
		separator = " ",
		items = {
			{ width = max_width },
			{ remaining = true },
		},
	})

	return displayer({ tail, { "󰉋 " .. path_name:sub(2, #path_name), "TelescopeResultsComment" } })
end

return buffer_path_display

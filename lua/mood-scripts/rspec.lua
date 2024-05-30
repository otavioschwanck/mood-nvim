local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

M.search_id = nil

M.quickfix_ns = vim.api.nvim_create_namespace("quickfix")

local function is_diagnostic_float(win_id)
	return vim.api.nvim_win_get_config(win_id).relative ~= ""
end

-- Function to close all diagnostic float windows
local function close_diagnostic_floats()
	local windows = vim.api.nvim_list_wins()

	for _, win_id in ipairs(windows) do
		if is_diagnostic_float(win_id) then
			vim.api.nvim_win_close(win_id, true)
		end
	end
end

local function custom_previewer(opts)
	opts = opts or {}
	return previewers.new_buffer_previewer({
		title = "File Preview",
		define_preview = function(self, entry, status)
			local filepath = entry.entry.filepath
			local linenr = tonumber(entry.entry.linenr)

			if filepath and vim.fn.filereadable(filepath) == 1 then
				vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.fn.readfile(filepath))
				local line_count = vim.api.nvim_buf_line_count(self.state.bufnr)

				local ft = vim.filetype.match({ filename = filepath })

				if ft then
					vim.bo[self.state.bufnr].filetype = ft

					if pcall(require, "nvim-treesitter") then
						require("nvim-treesitter.highlight").attach(self.state.bufnr, ft)
					else
						vim.cmd("syntax enable")
					end
				end

				if linenr and linenr > 0 and linenr <= line_count then
					vim.schedule(function()
						vim.api.nvim_buf_add_highlight(self.state.bufnr, -1, "Visual", linenr - 1, 0, -1)
						vim.api.nvim_win_set_cursor(status.preview_win, { linenr, 0 })
						-- center cursor on preview_win
						vim.cmd("normal! zz")
					end)
				end
			else
				print("File not found or not readable:", filepath)
				vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { "File not found: " .. filepath })
			end
		end,
	})
end

function M.go_to_backtrace()
	-- get the diagnostic on the line of type quickfix, get the message
	local diagnostic = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR, namespace = M.quickfix_ns })[1]

	if diagnostic then
		local message = diagnostic.message

		-- verify if diagnostic contains backtrace
		if string.match(message, "Backtrace:") then
			-- join message with \\n
			local lines = vim.split(message, "\n")
			local backtrace_line = nil

			local i = 1

			local backtraces = {}

			for _, line in ipairs(lines) do
				if string.match(line, "Backtrace:") and not backtrace_line then
					backtrace_line = i
				end

				if backtrace_line and i > backtrace_line then
					local path = vim.split(line, ":")[1]
					local linenr = vim.split(line, ":")[2]
					local error = vim.split(line, ":")[3]

					-- path is full system path.  Remove the /Users/username/etc with fnamemodify
					local display_path = vim.fn.fnamemodify(path, ":~:.")
					local display = display_path .. ":" .. linenr .. ":" .. error

					local item = {
						path = path .. ":" .. linenr,
						display = display,
						filepath = path,
						linenr = linenr,
					}

					local exists = false

					for _, backtrace in ipairs(backtraces) do
						if backtrace.filepath == item.filepath and backtrace.linenr == item.linenr then
							exists = true
						end
					end

					if not exists then
						table.insert(backtraces, item)
					end
				end

				i = i + 1
			end

			pickers
				.new({}, {
					prompt_title = "User Files",
					finder = finders.new_table({
						results = backtraces,
						entry_maker = function(entry)
							return {
								value = entry.path,
								display = entry.display or entry.path,
								ordinal = (entry.order or "") .. (entry.display or "") .. entry.path,
								entry = entry,
							}
						end,
					}),
					sorter = conf.generic_sorter({}),
					previewer = custom_previewer({}),
					attach_mappings = function(prompt_bufnr, _)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local local_of_backtrace = action_state.get_selected_entry().value

							local parsed_file = vim.split(local_of_backtrace, ":")[1]
							local parsed_line = vim.split(local_of_backtrace, ":")[2]

							if not vim.fn.filereadable(parsed_file) then
								print("File not found: " .. parsed_file)
								return
							end

							local win_exists = false

							local absolute_parsed_file = vim.fn.fnamemodify(parsed_file, ":p")

							for _, win in ipairs(vim.api.nvim_list_wins()) do
								local buf = vim.api.nvim_win_get_buf(win)
								local buf_file = vim.api.nvim_buf_get_name(buf)
								local absolute_buf_file = vim.fn.fnamemodify(buf_file, ":p")

								if absolute_buf_file == absolute_parsed_file then
									vim.api.nvim_set_current_win(win)

									vim.cmd("normal! " .. parsed_line .. "G")
									win_exists = true
									break
								end
							end

							if not win_exists then
								vim.cmd("vsplit " .. parsed_file)
								vim.cmd("normal! " .. parsed_line .. "G")
							end
						end)
						return true
					end,
				})
				:find()
		end
	else
		print("No diagnostics found here")
	end
end

function M.insert_diagnostics(lines)
	local diagnostics_by_bufnr = {}

	local error_count = 0

	local line_of_error = {}

	-- Ler o arquivo de quickfix
	for line in lines do
		if line ~= "finished" then
			-- Extrair as partes da linha
			local filename, lineno, message = line:match("([^:]+):(%d+): (.+)")

			error_count = error_count + 1

			-- verify if exists a buffer with filename open
			local bufnr = vim.fn.bufnr(filename)

			local already_inserted = false

			if diagnostics_by_bufnr[bufnr] then
				for _, diagnostic in ipairs(diagnostics_by_bufnr[bufnr]) do
					if diagnostic.real_message == message and diagnostic.lnum == lineno - 1 then
						already_inserted = true
					end
				end
			end

			if filename and lineno and message and not already_inserted and bufnr ~= -1 then
				lineno = tonumber(lineno)

				if not diagnostics_by_bufnr[bufnr] then
					diagnostics_by_bufnr[bufnr] = {}
				end

				local expanded_cur = vim.fn.fnamemodify(vim.fn.expand("%"), "%")
				local expanded_line = vim.fn.fnamemodify(filename, "%")

				if string.sub(expanded_cur, 1, 2) == "./" then
					expanded_cur = string.sub(expanded_cur, 3)
				end

				if string.sub(expanded_line, 1, 2) == "./" then
					expanded_line = string.sub(expanded_line, 3)
				end

				if expanded_cur == expanded_line then
					table.insert(line_of_error, lineno)
				end

				table.insert(diagnostics_by_bufnr[bufnr], {
					lnum = lineno - 1, -- Linhas no Neovim são indexadas a partir de 0
					col = 0,
					severity = vim.diagnostic.severity.ERROR,
					source = "quickfix",
					message = message:gsub("\\n", "\n"),
					real_message = message,
				})
			end
		end
	end

	for bufnr, diagnostics in pairs(diagnostics_by_bufnr) do
		vim.diagnostic.set(M.quickfix_ns, bufnr, diagnostics)
	end

	if #line_of_error > 0 then
		-- create a mark to go back with C-o
		vim.cmd("normal! m'")

		local cursor_line_number = vim.fn.line(".")

		local closest_of_the_cursor_line_number = nil

		for _, line in ipairs(line_of_error) do
			if not closest_of_the_cursor_line_number then
				closest_of_the_cursor_line_number = line
			elseif
				math.abs(cursor_line_number - line) < math.abs(cursor_line_number - closest_of_the_cursor_line_number)
			then
				closest_of_the_cursor_line_number = line
			end
		end

		if closest_of_the_cursor_line_number ~= cursor_line_number then
			vim.api.nvim_win_set_cursor(0, { closest_of_the_cursor_line_number, 0 })
		end

		close_diagnostic_floats()

		vim.defer_fn(function()
			vim.diagnostic.open_float()
		end, 30)
	end

	if error_count == 0 then
		print("All Tests Passed!")
	elseif error_count == 1 then
		print(error_count .. " Test Failed!")
	else
		print(error_count .. " Tests Failed!")
	end
end

function M.generate_random_search_id()
	M.search_id = os.time() .. math.random()

	return M.search_id
end

function M.clear_diagnostics()
	vim.diagnostic.reset(M.quickfix_ns)
end

local function file_exists()
	local f = io.open("/tmp/quickfix.out", "r")
	return f ~= nil and io.close(f)
end

function M.wait_quickfix_to_insert_diagnostics(retry_count, search_id)
	retry_count = retry_count or 0

	if search_id and search_id ~= M.search_id then
		return
	end

	search_id = search_id or M.generate_random_search_id()

	if retry_count > 1100 then
		return
	end

	local lines
	local file_size

	if file_exists() then
		lines = io.lines("/tmp/quickfix.out")

		file_size = vim.fn.getfsize("/tmp/quickfix.out")
	end

	vim.defer_fn(function()
		if lines and file_size > 0 then
			M.insert_diagnostics(lines)
		else
			M.wait_quickfix_to_insert_diagnostics(retry_count + 1, search_id)
		end
	end, 300)
end

return M

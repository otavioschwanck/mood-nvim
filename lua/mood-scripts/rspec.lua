local M = {}

M.search_id = nil

M.quickfix_ns = vim.api.nvim_create_namespace("quickfix")

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

				if vim.fn.fnamemodify(vim.fn.expand("%"), "%") == vim.fn.fnamemodify(filename, "%") then
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

		vim.api.nvim_win_set_cursor(0, { closest_of_the_cursor_line_number, 0 })

		vim.defer_fn(function()
			vim.diagnostic.open_float()
		end, 50)
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

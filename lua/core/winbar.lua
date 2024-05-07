local M = {}

local catppuccin_palette = require("catppuccin.palettes").get_palette()

vim.api.nvim_set_hl(0, "WinBarPath", { fg = catppuccin_palette.overlay2 })
vim.api.nvim_set_hl(0, "WinBarFileName", { fg = catppuccin_palette.text })
vim.api.nvim_set_hl(0, "WinBarModified", { fg = catppuccin_palette.red })

function M.eval()
	local file_path = vim.api.nvim_eval_statusline("%f", {}).str
	local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "⊚" or ""

	if string.match(file_path, "^~/") then
		file_path = vim.fn.fnamemodify(file_path, ":~:.")
	end

	local splitted_path = vim.split(file_path, "/")

	local path = ""
	local filename = ""

	if #splitted_path == 1 then
		path = ""
		filename = splitted_path[#splitted_path]
	else
		path = table.concat(vim.list_slice(splitted_path, 1, #splitted_path - 1), "/")
		filename = splitted_path[#splitted_path]
	end

	local status = require("arrow.statusline").text_for_statusline_with_icons()

	return "%#WinBarPath#  "
		.. path
		.. "/%*%#WinBarFileName#"
		.. filename
		.. "%* "
		.. "%#WinBarModified#"
		.. (not (modified == "") and (modified .. " ") or "")
		.. "%*"
		.. status
end

return M

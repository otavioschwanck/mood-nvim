local utils = require("new-file-template.utils")

local function base_template(relative_path, filename)
	local file = vim.split(filename, "%.")[1]

	return string.format(
		[[
const %s = () => {
  |cursor|  
}

export default %s]],
		file,
		file
	)
end

local function index_template(relative_path, filename)
	local file = vim.split(relative_path, "/")
	file = file[#file]

	return string.format(
		[[
import * from "./%s";|cursor|]],
		file
	)
end

--- @param opts table
---   A table containing the following fields:
---   - `full_path` (string): The full path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `relative_path` (string): The relative path of the new file, e.g., "lua/new-file-template/templates/init.lua".
---   - `filename` (string): The filename of the new file, e.g., "init.lua".
return function(opts)
	local template = {
		{ pattern = ".*components/.*index.tsx", content = index_template },
		{ pattern = ".*components/.*", content = base_template },
	}

	return utils.find_entry(template, opts)
end

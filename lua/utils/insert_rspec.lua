local split = require("utils.table_functions").Split
local toCamel = require("utils.table_functions").camelCaseB
local singularize = require("utils.table_functions").singularize

local function insert_test_template()
	local relative_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
	local splitted_path = split(relative_path, "/")
	local class_name = ""

	for i = 3, #splitted_path do
		class_name = class_name .. toCamel(split(splitted_path[i], "_spec.rb")[1])

		if i < #splitted_path then
			class_name = class_name .. "::"
		end
	end

	local type = singularize(splitted_path[2])

	local text_to_insert = {
		'require "rails_helper"',
		"",
		"RSpec.describe " .. class_name .. ", type: :" .. type .. " do",
		"",
		"end",
	}

	vim.api.nvim_buf_set_lines(0, 0, 4, false, text_to_insert)
	vim.fn.feedkeys("3jI  ")
end

return insert_test_template

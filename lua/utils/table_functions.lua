local M = {}

function M.Split(s, delimiter)
	local result = {}

	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end

	return result
end

function M.camelCaseB(s)
	local camel = string.gsub(s, "_%a+", function(word)
		local first = string.sub(word, 2, 2)
		local rest = string.sub(word, 3)
		return string.upper(first) .. rest
	end)

	return string.upper(string.sub(camel, 1, 1)) .. string.sub(camel, 2, #camel)
end

M.pluralize = function(inputString)
	local lastCharacter = inputString:sub(-1, -1)

	if lastCharacter == "y" then
		local stringWithoutY = inputString:sub(1, -2)

		return stringWithoutY .. "ies"
	elseif lastCharacter == "s" then
		return inputString
	else
		return inputString .. "s"
	end
end

M.singularize = function(inputString)
	local lastCharacter = inputString:sub(-1, -1)

	local lastThreeCharacters = ""
	local lastTwoCharacters = ""

	if #inputString >= 3 then
		lastThreeCharacters = inputString:sub(-3, -1)
	end

	if #inputString >= 2 then
		lastTwoCharacters = inputString:sub(-2, -1)
	end

	if lastThreeCharacters == "ies" then
		local stringWithoutIes = inputString:sub(1, -4)

		return stringWithoutIes .. "y"
	elseif lastTwoCharacters == "ss" then
		return inputString
	elseif lastCharacter == "s" then
		return inputString:sub(1, -2)
	else
		return inputString
	end
end

function M.SplitWithDot(s)
	local lines = {}
	for line in s:gsub("%f[.]%.%f[^.]", "\0"):gmatch("%Z+") do
		table.insert(lines, line)
	end

	return lines
end

return M

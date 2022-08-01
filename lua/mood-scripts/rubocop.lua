vim.notify = require("notify")

local function filter_inplace(arr, func)
    local new_index = 1
    local size_orig = #arr
    for old_index, v in ipairs(arr) do
        if func(v, old_index) then
            arr[new_index] = v
            new_index = new_index + 1
        end
    end
    for i = new_index, size_orig do arr[i] = nil end
end

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local function comment_rubocop()
  local error = vim.diagnostic.get()
  local line = vim.fn.line(".")
  local bufnr = vim.fn.bufnr()
  local current_error

---@diagnostic disable-next-line: unused-local
  for __, v in ipairs(error) do
    if v.lnum + 1 == line and bufnr == v.bufnr then
      if not current_error then
        current_error = v
      end
    end
  end

  if current_error then
    local message = current_error.message
    local current_line = vim.fn.getline(".")
    local parsed_message = Split(message, " ")[1]
    parsed_message = string.gsub(parsed_message, "%[", "")
    parsed_message = string.gsub(parsed_message, "%]", "")

    if string.match(current_line, "# rubocop:disable") then
      vim.cmd("normal! A, " .. parsed_message)
    else
      vim.cmd("normal! A # rubocop:disable " .. parsed_message)
    end
  end
end

return { comment_rubocop = comment_rubocop }

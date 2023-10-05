local M = {}

function M.grep_layout()
	local columns = vim.o.columns
  local lines = vim.o.lines

  if columns > 280 and lines > 30 then
    return "horizontal"
  elseif lines > 30 then
    return "vertical"
  else
    return "flex"
  end
end

return M

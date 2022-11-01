local maximize = function()
  local currentLine = vim.fn.line('.')

  vim.cmd("tabnew %")
  vim.cmd("" .. currentLine)
  vim.cmd("norm! zz")

  vim.g.maximized = true
end

local toggleMaximize = function()
  if vim.g.maximized then
    if vim.fn.tabpagenr() ~= 1 then
      vim.cmd("tabclose")

      vim.g.maximized = false
    else
      vim.g.maximized = false

      maximize()
    end
  else
    if require('utils.buf_count')() > 1 then
      maximize()
    end
  end
end

return toggleMaximize

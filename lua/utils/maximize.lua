local toggleMaximize = function()
  if vim.g.maximized then
    vim.cmd("tabclose")

    vim.g.maximized = false
  else
    local currentLine = vim.fn.line('.')

    vim.cmd("tabnew %")
    vim.cmd("" .. currentLine)

    vim.g.maximized = true
  end
end

return toggleMaximize

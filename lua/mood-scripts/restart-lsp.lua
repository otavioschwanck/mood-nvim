local M = {}

function M.restart_lsp()
  vim.diagnostic.reset()

  vim.cmd("LspStart")
end

return M

local M = {}

function M.restart_lsp()
  local null_ls = require("null-ls")

  vim.diagnostic.reset()

  vim.cmd("LspStart")
end

return M

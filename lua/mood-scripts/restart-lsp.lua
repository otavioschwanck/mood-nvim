local M = {}

function M.restart_lsp()
  local null_ls = require("null-ls")

  vim.diagnostic.reset()

  null_ls.toggle({})

  vim.lsp.stop_client(vim.lsp.get_active_clients())

  vim.fn.timer_start(150, function()
    vim.cmd("LspStart")

    null_ls.toggle({})
  end)
end

return M

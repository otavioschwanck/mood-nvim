local M = {}

function M.setup()
  vim.cmd('call timer_start(4000, {-> execute("call OpenCommand()") })')

  require('telescope').setup({
    defaults = {
      file_ignore_patterns = vim.g.folder_to_ignore,
    }
  })
end

return M

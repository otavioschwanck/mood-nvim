local M = {}

function M.setup()
  require('telescope').setup({
    defaults = {
      file_ignore_patterns = vim.g.folder_to_ignore,
    }
  })
end

return M

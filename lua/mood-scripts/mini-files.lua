local M = {}

M.path_tail = (function()
  local os_sep = "/"

  return function(path)
    for i = #path, 1, -1 do
      if path:sub(i, i) == os_sep then
        return path:sub(i + 1, -1)
      end
    end
    return path
  end
end)()

function M.open_current()
  local files = require('mini.files')

  if vim.bo.filetype == 'minifiles' then
    files.close()
  else
    files.open(vim.api.nvim_buf_get_name(0))
    files.reveal_cwd()
  end
end

function M.open_folder(folder)
  local files = require('mini.files')

  files.open(folder)
  files.reset()
  files.reveal_cwd()
end

return M

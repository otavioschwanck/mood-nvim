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
    local is_file = not vim.bo.buftype or vim.bo.buftype == ''
    local current_file = vim.fn.expand("%:p")

    if is_file then
      files.open(vim.fn.expand("%:p:h"))
      files.reset()
      files.reveal_cwd()

      vim.schedule(function()
        local line_num = 1
        local entry = files.get_fs_entry(0, line_num)

        while entry do
          line_num = line_num + 1

          if M.path_tail(current_file) == entry.name then
            vim.api.nvim_win_set_cursor(0, { line_num, 1 })
            return
          end

          entry = files.get_fs_entry(0, line_num)
        end
      end)
    end
  end
end

function M.open_folder(folder)
  local files = require('mini.files')

  files.open(folder)
  files.reset()
  files.reveal_cwd()
end

return M

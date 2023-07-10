local M = {}

function M.open_current()
  local files = require('mini.files')
  if vim.bo.filetype == 'minifiles' then
    files.close()
  else
    local current_file = vim.api.nvim_buf_get_name(0)
    local is_file = not vim.bo.buftype or vim.bo.buftype == ''

    files.open(vim.loop.cwd(), false)

    if is_file then
      vim.schedule(function()
        files.reset()
        local line = 1
        local entry = files.get_fs_entry(0, line)
        while entry do
          if not entry then
            return
          end

          if current_file == entry.path then
            vim.api.nvim_win_set_cursor(0, { line, 1 })
            return
          elseif
              current_file:find(
                string.format('%s/', entry.path),
                1,
                true
              ) == 1
          then
            vim.api.nvim_win_set_cursor(0, { line, 1 })
            require('mini.files').go_in()
            line = 1
          else
            line = line + 1
          end
          entry = files.get_fs_entry(0, line)
        end
      end)
    end
  end
end

return M

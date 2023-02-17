local M = {}

local buf_count = require('utils.buf_count')

function M.save_session()
  local file_type = vim.bo.filetype

  if buf_count() > 1 and file_type ~= 'alpha' then
    require('persistence').save()
  end
end

function M.setup()
  vim.cmd([[
    call timer_start(1000 * 60, { id -> execute("lua require('mood-scripts.auto-save-session').save_session()") }, { 'repeat': -1 })
  ]])
end

return M


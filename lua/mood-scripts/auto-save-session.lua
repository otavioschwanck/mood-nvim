local M = {}

function M.save_session()
  local file_type = vim.bo.filetype

  if file_type ~= 'alpha' then
    require('persistence').save()
  end
end

function M.setup()
  vim.cmd([[
    call timer_start(1000 * 15, { id -> execute("lua require('mood-scripts.auto-save-session').save_session()") }, { 'repeat': -1 })
  ]])
end

return M


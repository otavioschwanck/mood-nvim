local M = {}

function M.save_session(ft)
  if vim.g.exiting == false and ft.file and ft.file ~= "" then
    vim.fn.timer_start(100, function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })

      require('persistence').save()
    end)
  end
end

return M


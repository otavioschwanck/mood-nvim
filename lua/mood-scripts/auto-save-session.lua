local M = {}

function M.save_session(ft)
  if vim.g.scheduled_save_session == true then
    return
  end

  if vim.g.exiting == false and ft.file and ft.file ~= "" then
    vim.g.scheduled_save_session = true

    vim.fn.timer_start(1500, function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })

      require('persistence').save()

      vim.g.scheduled_save_session = false
    end)
  end
end

return M


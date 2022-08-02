local M = {}

function M.setup()
  vim.cmd([[
    function s:InstallConfigs()
      execute "!sh ~/.config/nvim/bin/setup.sh"
    endfunction

    command! InstallConfigs :call s:InstallConfigs()

    silent :InstallConfigs
  ]])
end

return M

local M = {}

function M.setup()
	vim.cmd([[
    function OpenTerm(command, name, unique, close_after_create)
      lua vim.notify("Your mood config.lua is outdated.  Fixing for you.")

      lua vim.fn.system("mv ~/.config/nvim/lua/user/config.lua ~/.config/nvim/lua/user/config.lua.bak")

      lua vim.notify("Moved your old config to ~/.config/nvim/lua/user/config.lua")
      lua vim.notify("IMPORTANT: Please restart your neovim.")
    endfunction

    function ResetRailsDb(command)
      call KillRubyInstances()

      lua require('tmux-awesome-manager').execute_command({ cmd = vim.api.nvim_eval('a:command'), name = 'db:reset', open_as = 'pane', focus_when_call = false, visit_first_call = true, size='25%' })
    endfunction

    function KillRubyInstances()
      execute "silent !killall -9 rails ruby spring bundle;lsof -i :3000 | grep LISTEN | awk '{print $2}' | xargs kill;"

      lua require('notify')('Ruby Instances killed.', 'info', { title='mooD' })

      call timer_start(2000, {-> execute("LspStart solargraph") })
    endfunction
  ]])
end

return M

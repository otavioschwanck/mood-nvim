return {
  {
    'glepnir/dashboard-nvim',
    config = function()

      local header = {
        '',
        '',
        '',
        '',
        '███╗   ███╗ ██████╗  ██████╗ ██████╗     ███╗   ██╗██╗   ██╗██╗███╗   ███╗',
        '████╗ ████║██╔═══██╗██╔═══██╗██╔══██╗    ████╗  ██║██║   ██║██║████╗ ████║',
        '██╔████╔██║██║   ██║██║   ██║██║  ██║    ██╔██╗ ██║██║   ██║██║██╔████╔██║',
        '██║╚██╔╝██║██║   ██║██║   ██║██║  ██║    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        '██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██████╔╝    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
        '╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═════╝     ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
        '',
        'Final Version!',
        '',
        ''
      }

      local no_tmux = vim.fn.system("echo $TMUX"):gsub("\n", "") == ""

      if (no_tmux) then
        table.insert(header, "[WARNING] You are not using tmux.  Some terminals features will not work.")
        table.insert(header, "See the handbook (SPC h h) to learn about TMUX and Alacritty.")
      end

      local items = {
        { desc = ' Git status                   ', key = 'SPC TAB', action = 'Telescope git_status' },
        { desc = ' Harpoon                      ', key = '   ;   ',
          action = 'lua require("mood-scripts.harpoon-menu")()' },
        { desc = ' Find Files                   ', key = 'SPC SPC', action = 'Telescope find_files' },
        { desc = ' Recent Files                 ', key = 'SPC f r', action = 'Telescope oldfiles' },
        { desc = ' User Settings                ', key = 'SPC f p',
          action = "lua require('mood-scripts.open-user-configs').call()" },
        { desc = ' Open Handbook (docs)         ', key = 'SPC h h', action = 'e ~/.config/nvim/handbook.md' },
        { desc = 'ﲉ Open Tutorial for mooD       ', key = 'SPC h T', action = 'lua require("tutorial").start()' },
        { desc = ' Update mooD                  ', key = 'SPC h u', action = 'UpdateMood' },
      }

      require('dashboard').setup {
        theme = 'doom',
        config = {
          header = header,
          center = items
        }
      }
    end
  }
}

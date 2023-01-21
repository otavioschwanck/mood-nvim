return {
  {
    'glepnir/dashboard-nvim',
    config = function()

      local db = require('dashboard')

      db.custom_header = {
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
        table.insert(db.custom_header, "[WARNING] You are not using tmux.  Some terminals features will not work.")
        table.insert(db.custom_header, "See the handbook (SPC h h) to learn about TMUX and Alacritty.")
      end

      db.hide_statusline = false

      db.custom_center = {
        { desc = ' Git status                   ', shortcut = 'SPC TAB', action = 'Telescope git_status' },
        { desc = ' Harpoon                      ', shortcut = '   ;   ',
          action = 'lua require("mood-scripts.harpoon-menu")()' },
        { desc = ' Find Files                   ', shortcut = 'SPC SPC', action = 'Telescope find_files' },
        { desc = ' Recent Files                 ', shortcut = 'SPC f r', action = 'Telescope oldfiles' },
        { desc = ' User Settings                ', shortcut = 'SPC f p',
          action = "lua require('mood-scripts.open-user-configs').call()" },
        { desc = ' Open Handbook (docs)         ', shortcut = 'SPC h h', action = 'e ~/.config/nvim/handbook.md' },
        { desc = 'ﲉ Open Tutorial for mooD       ', shortcut = 'SPC h T', action = 'lua require("tutorial").start()' },
        { desc = ' Update mooD                  ', shortcut = 'SPC h u', action = 'UpdateMood' },
      }
    end
  }
}

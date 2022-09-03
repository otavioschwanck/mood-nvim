local M = {}

function M.setup()
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
        'Version 2.0.1',
        '',
        ''
  }

  db.custom_footer = { "" }

  db.hide_statusline = false

  db.custom_center = {
    { desc = ' Git status                   ', shortcut = 'SPC TAB', action = 'Telescope git_status' },
    { desc = ' Recent Files                 ', shortcut = 'SPC f r', action = 'Telescope oldfiles' },
    { desc = ' Open Handbook (docs)         ', shortcut = 'SPC h h', action = 'e ~/.config/nvim/handbook.md' },
    { desc = 'ﲉ Open Tutorial for mooD       ', shortcut = 'SPC h T', action = 'lua require("tutorial").start()' },
    { desc = ' User Settings                ', shortcut = 'SPC f p', action = 'e ~/.config/nvim/lua/user/config.lua' },
    { desc = ' User Plugins                 ', shortcut = 'SPC f P', action = 'e ~/.config/nvim/lua/user/plugins.lua' },
    { desc = ' User CoC                     ', shortcut = 'SPC f L', action = 'e ~/.config/nvim/coc-settings.json' },
    { desc = ' Update mooD                  ', shortcut = 'SPC h u', action = 'UpdateMood' },
  }
end

return M

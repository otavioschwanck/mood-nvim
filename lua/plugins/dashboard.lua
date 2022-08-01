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
        'Version 1.3.0',
        '',
        ''
  }

  db.custom_footer = { "" }

  db.custom_center = {
    { desc = ' Git status                   ', shortcut = 'SPC TAB', action = 'Telescope git_status' },
    { desc = ' Recent Files                 ', shortcut = 'SPC f r', action = 'Telescope oldfiles' },
    { desc = ' Open Handbook (docs)         ', shortcut = 'SPC h h', action = 'e ~/.config/nvim/handbook.md' },
    { desc = ' User Settings                ', shortcut = 'SPC f p', action = 'e ~/.config/nvim/user.vim' },
    { desc = ' User Plugins                 ', shortcut = 'SPC f P', action = 'e ~/.config/nvim/lua/user-plugins.lua' },
    { desc = ' User LSP                     ', shortcut = 'SPC h l', action = 'e ~/.config/nvim/lua/user_lsp.lua' },
    { desc = ' Update mooD                  ', shortcut = 'SPC h u', action = 'UpdateMood' },
  }
end

return M

local db = require('dashboard')

local load_notices = function()
  local user_file = vim.fn.shellescape(vim.fn.fnamemodify('~/.config/nvim/user.vim', ':p'))
  local path = user_file.sub(user_file, 2, #user_file - 1)

  if vim.fn.match(vim.fn.readfile(path), 'colorscheme catppuccin') ~= -1 then
    db.custom_footer = { "Breaking Changes:  Catppuccin theme is no longer supported.  Please change to onedarkpro on your User Settings." }

    require('notify')('Breaking Changes:  Catppuccin theme is no longer supported.  Please change to onedarkpro on your User Settings.', 'warn', { title='mooD' })
  end
end

return load_notices

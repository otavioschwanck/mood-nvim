-- Add your plugins here

local user_plugins = {
  -- 'kat0h/nyancat.vim',
  { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
}

return user_plugins

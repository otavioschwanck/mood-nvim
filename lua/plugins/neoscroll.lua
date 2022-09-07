local M = {}

function M.setup()
  require('neoscroll').setup({})

  local t = {}
  -- Syntax: t[keys] = {function, {function arguments}}
  t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '130'}}
  t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '130'}}
  t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '350'}}
  t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '350'}}
  t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
  t['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
  t['zt']    = {'zt', {'200'}}
  t['zz']    = {'zz', {'200'}}
  t['zb']    = {'zb', {'200'}}

  require('neoscroll.config').set_mappings(t)
end

return M

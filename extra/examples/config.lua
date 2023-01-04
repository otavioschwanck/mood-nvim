-- SETTINGS ---------------------------------------
-- Use this file to configure your settings/plugins
---------------------------------------------------

-- Theme?
vim.cmd('colorscheme kanagawa') -- SPC h t to see more themes

-- Configure your per project commands.  See more at: https://github.com/otavioschwanck/tmux-awesome-manager.nvim
-- Run the per project with SPC #
require('tmux-awesome-manager').setup({
  -- Open in separated session?
  -- project_open_as = 'separated_session',
  -- session_name = 'Neovim Terms',
  per_project_commands = {
    api = { { cmd = 'rails s', name = 'Rails Server' } },
    front = { { cmd = 'yarn start', name = 'react server' } }
  },
  default_size = '30%',
  open_new_as = 'pane', -- change to window to open terms in new tab
})

-- Directory to store your notes (SPC z z)
vim.g.notes_directories = { '~/Documents/Notes' }
vim.g.ruby_debugger = "debugger" -- can be changed to byebug or pry, call with SPC d

local two_space_languages = { "ruby", "yaml", "javascript", "typescript", "typescriptreact", "javascriptreact", "eruby", "lua", }
local four_space_languages = { "solidity" }

-- autocmd array(AutoCmd, pattern, callback)
local autocommands = {
  { {"FileType"}, two_space_languages, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end },
  { {"FileType"}, four_space_languages, function() vim.cmd('setlocal shiftwidth=4 tabstop=4') end },
  -- { {'BufWritePre'}, {"*.tsx", "*.ts", "*.jsx", "*.js"}, function() vim.cmd("Prettier") end, }, -- prettifer on save
  -- { {'BufWritePre'}, {"*.rb"}, function() vim.lsp.buf.format { async = false, filter = function(client) return client.name == "solargraph" end } end, } -- rubocop on save
}

-- loading the autocmds
for i = 1, #autocommands, 1 do
  vim.api.nvim_create_autocmd(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
end

-- see more at https://github.com/otavioschwanck/telescope-alternate.nvim
require('telescope-alternate').setup({
  mappings = {
    { pattern = 'app/services/(.*)_services/(.*).rb', targets = {
      { template =  'app/contracts/[1]_contracts/[2].rb', label = 'Contract' }
    } },
    { 'app/contracts/(.*)_contracts/(.*).rb', { { 'app/services/[1]_services/[2].rb', 'Service' } } },
    { 'src/(.*)/service(.*)/(.*).service.ts', { { 'src/[1]/controller*/*.controller.ts', 'Controller', true }, { 'src/[1]/dto/*', 'DTO', true } } },
    { 'src/(.*)/controller(.*)/(.*).controller.ts', { { 'src/[1]/service*/*.service.ts', 'Service', true }, { 'src/[1]/dto/*', 'DTO', true } } },
    { 'src/(.*)/dto(.*)/(.*)', { { 'src/[1]/service*/*.service.ts', 'Service', true }, { 'src/[1]/controller*/*.controller.ts', 'Controller', true } } },
  }
})

vim.g.folder_to_ignore = { ".*.git/.*", "node_modules/.*", "sorbet/.*" } -- Ignore some folders on search?

-- Mouse?
vim.api.nvim_set_option('mouse', 'a')

local set = vim.api.nvim_set_option
set('relativenumber', true) -- relative numbers?

require('core.settings').remove_bicycle_small_whells({ includeNormalMode = true })

-- set('colorcolumn', '125') -- column length helper

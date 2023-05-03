-- SETTINGS ---------------------------------------
-- Use this file to configure your settings/plugins
---------------------------------------------------

-- Theme?
vim.g.colors_name = 'tokyonight-moon' -- SPC h t to see more themes

-- Configure your per project commands.  See more at: https://github.com/otavioschwanck/tmux-awesome-manager.nvim
-- Run the per project with SPC #
require('tmux-awesome-manager').setup({
  -- Open in separated session?
  project_open_as = 'window', --  can be 'separated_session' and 'window'
  session_name = 'Neovim Terms',
  per_project_commands = {
    api = { { cmd = 'rails s', name = 'Rails Server' } },
    front = { { cmd = 'yarn start', name = 'react server' } }
  },
  default_size = '25%', -- use Alt + , and Alt + ; to switch between neovim and tmux panes
  use_icon = true,
  open_new_as = 'pane', -- change to window to open terms in new tab
})

-- Directory to store your notes (SPC z z)
vim.g.ruby_debugger = "debugger" -- can be changed to byebug or pry, call with SPC d

local two_space_languages = { "ruby", "yaml", "javascript", "typescript", "typescriptreact", "javascriptreact", "eruby", "lua", }
local four_space_languages = { "solidity" }

-- autocmd array(AutoCmd, pattern, callback)
-- Add your format on save here
local autocommands = {
  { {"FileType"}, two_space_languages, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end },
  { {"FileType"}, four_space_languages, function() vim.cmd('setlocal shiftwidth=4 tabstop=4') end },
  -- { {'BufWritePre'}, {"*.tsx", "*.ts", "*.jsx", "*.js"}, function() vim.cmd("LspZeroFormat") end, }, -- Format on save for those languages. You can also call SPC c f to format.
  -- { {'BufWritePre'}, {"*.rb"}, function() vim.lsp.buf.format { async = false, filter = function(client) return client.name == "solargraph" end } end, } -- rubocop on save
}

-- loading the autocmds
for i = 1, #autocommands, 1 do
  vim.api.nvim_create_autocmd(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
end

-- Use SPC f d to navigate to your dotfiles, configure then here.
vim.g.dotfiles = {
  { path = "~/.zshrc", display = "zshrc" },
  { path = "~/.config/alacritty/alacritty.yml", display = "Alacritty" },
  { path = "~/.tmux.conf", display = "TMUX" },
  { path = "~/Library/Application Support/lazygit/config.yml", display = "Lazygit" },
  -- { path = "~/.config/lazygit/config.yml", display = "Lazygit" }, -- (for Linux)
  { path = "~/.gitconfig", display = "GitConfig" }
}

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

vim.g.folder_to_ignore = { ".*.git/.*", "node_modules/.*", "sorbet/.*", "tmp/.*", "public/.*" } -- Ignore some folders on search?

-- access your dotfiles with SPC f d
vim.g.dotfiles = {
  { path = "~/.zshrc", display = "zshrc" },
  { path = "~/.config/alacritty/alacritty.yml", display = "Alacritty" },
  { path = "~/.tmux.conf", display = "TMUX" },
  { path = "~/Library/Application Support/lazygit/config.yml", display = "Lazygit" },
  -- { path = "~/.config/lazygit/config.yml", display = "Lazygit" }, -- (for Linux)
  { path = "~/.gitconfig", display = "GitConfig" }
}

-- Mouse?
vim.api.nvim_set_option('mouse', 'a')

local set = vim.api.nvim_set_option
-- set('relativenumber', true) -- relative numbers?

require('core.settings').remove_bicycle_small_whells({ includeNormalMode = true })

-- set('colorcolumn', '125') -- column length helper

-- Auto load session
-- require("persistence").load()


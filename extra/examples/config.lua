-- Theme?
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
vim.cmd('colorscheme catppuccin')

-- Directory to store your notes (SPC z z)
vim.g.notes_directories = { '~/Documents/Notes' }
vim.g.ruby_debugger = "require 'pry'; binding.pry"

-- Function Helpers
local set = vim.api.nvim_set_option
local au = vim.api.nvim_create_autocmd
local call_term = require('helpers.user-functions').call_term
local find_in_folder = require('helpers.user-functions').find_in_folder
local wk = require("which-key")

-- Disable arrow keys?  (Recommended, learn to use w, W, e, E, b, f, t, }, {)
require('core.settings').remove_bicycle_small_whells({ includeNormalMode = true })

-- Here you can set your mappings to SPC
-- Examples o = { r = { "command", "description" } } = SPC o r to call
wk.register({
  -- Example of custom terminal commands
  ["="] = { ":w | :silent !bundle exec rubocop -A %<CR>", "Rubocop on current file" },
  ["+"] = call_term('bundle exec rubocop -A', 'rubocop', 2, 0, { pre_command = ':w |' }),
  o = {
    d = {
      name = "+Dotfiles",
      a = { ":e ~/.config/alacritty/alacritty.yml<CR>", "Alacritty Config" },
      t = { ":e ~/.tmux.conf<CR>", "Tmux Config" },
      y = { ":e ~/Library/Application Support/lazygit/config.yml<CR>", "LazyGit Config" }, -- (For MAC)
      -- y = { ":e ~/.config/lazygit/config.yml<CR>" }, -- (For Linux)
      g = { ":e ~/.gitconfig<CR>", "Open Git Config" },
      z = { ":e ~/.zshrc<CR>", "Open zshrc" }
    },
    y = {
      name = "+yarn",
      i = call_term('yarn install', 'Yarn Install', 1, 0),
      a = call_term('yarn add', 'Yarn Add', 1, 0, { input = "plugin name: " }),
      d = call_term('yarn dev', 'Yarn Dev', 1, 1),
    },
    r = { ":silent !bundle exec rubocop -a %<CR>", "Rubocop on current file" },
    name = "+Term Commands",
    ["1"] = call_term('docker-compose up -d', 'Docker Compose UP', 1, 1),
    b = {
      name = "+Brownie",
      t = call_term('brownie test', 'Brownie Test', 2, 0),
      C = call_term('brownie compile', 'Brownie Compile', 2, 0),
      c = call_term('brownie console', 'Brownie Console', 1, 0),
    },
  },
  r = { -- Add your rails folders and commands here.  SPC r + key
    name = "+Rails",
    r = call_term('rails c', 'Rails Console', 1, 0),
    R = call_term('rails s', 'Rails Server', 1, 1),
    S = call_term('bundle exec sidekiq', 'Sidekiq', 1, 1),
    b = call_term('bundle install', 'Bundle Install', 1, 0),
    g = call_term('rails generate', 'Rails Generate', 2, 0, { input="rails generate: " }),
    d = call_term('rails destroy', 'Rails Destroy', 2, 0, { input="rails destroy: "}),
    i = call_term('rails db:migrate', 'migrate', 2, 0),
    I = { ":call ResetRailsDb('bin/rails db:environment:set RAILS_ENV=development; rails db:drop db:create db:migrate;rails db:seed')<CR>", "Rails Reset DB" },
    m = find_in_folder('app/models', 'Find Model'),
    q = find_in_folder('app/contracts', 'Find Contracts'),
    z = find_in_folder('app/serializers', 'Find Serialiazers'),
    c = find_in_folder('app/controllers', 'Find Controller'),
    v = find_in_folder('app/views', 'Find View'),
    a = find_in_folder('config/locales', 'Find Locales'),
    u = find_in_folder('spec/factories', 'Find Factories'),
    s = find_in_folder('app/services', 'Find Services'),
    n = find_in_folder('db/migrate', 'Find Migration'),
    M = { ":Emodel<CR>", "Find Model" },
    C = { ":Econtroller<CR>", "Find Controller" },
    K = { ":call KillRubyInstances()<CR>", "Kill Ruby Instances" },
    U = { ":Efixtures<CR>", "Find Current Fixture" },
    V = { ":Eview <C-r>=Wildchar()<CR>", "Find views" },
    N = { ":Emigration<CR>", "Find Current Migration" },
  }
}, { prefix = "<leader>", silent = false })

-- Run Pre-defined terminal commands per project.  If a open_term shortcut exists at top, please use same Name. Examples:
--                            --    |command 1 | Name 1       |   |command 2 | Name 2       |       | command 3 |                    | Name 3 |
-- local rails_project_startup = { { "rails s", "Rails Server" }, { "rails c", "Rails Console" }, { "docker compose up -d postgres", "Start Db" } }
-- vim.g.commands_for_autostart = {
--   -- project folder name            -- commands to run
--   ["my-api-folder-name"]          = rails_project_startup,
--   ["my-second-rails-folder-name"] = rails_project_startup,
--   ["my-front-folder-name"]        = { { 'yarn dev', 'Yarn Dev' } }
-- }

-- You can also enable those commands on vim startup by commenting:
vim.g.disable_autostart_commands = 1 -- With this, you have to press SPC # to open the autostart terminals.  I personally prefer this option.

-- Alternate file with SPC f a
-- se more at https://github.com/otavioschwanck/telescope-alternate.nvim
require('telescope-alternate').setup({
  mappings = {
    { 'app/services/(.*)_services/(.*).rb', {
      { 'app/contracts/[1]_contracts/[2].rb', 'Contract' }
    } },
    { 'app/contracts/(.*)_contracts/(.*).rb', { { 'app/services/[1]_services/[2].rb', 'Service' } } },
  },
  presets = { 'rails' }
})

local two_space_languages = { "ruby", "yaml", "javascript", "typescript", "typescriptreact", "javascriptreact", "eruby", "lua" }
local four_space_languages = { "solidity" }

-- autocmd array(AutoCmd, pattern, callback)
local autocommands = {
  { {"FileType"}, two_space_languages, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end },
  { {"FileType"}, four_space_languages, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end },
  -- { {'BufWritePre'}, {"*.rb"}, function() vim.lsp.buf.format { async = false } end, }, -- rubocop on save (THIS IS AWESOME AS HELL, UNCOMMENT TO TEST IT)
  -- Prettier for TS/JS:
  -- { {'BufWritePre'}, {"*.tsx", "*.ts", "*.jsx", "*.js"}, function() vim.cmd("PrettierAsync") end, } -- Run Command before save (can be any command)
}

for i = 1, #autocommands, 1 do
  au(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
end


-- If you don't use pyenv or other path, please uncomment this: (Make sure that python provider is OK on :checkhealth)
-- To find where is the path of python, run which python and which python3.
-- vim.g.python_host_prog = '/usr/bin/python'
-- vim.g.python3_host_prog = '/usr/bin/python3'

-- vim.g.folder_to_ignore = { ".*.git/.*", "node_modules/.*", "sorbet/.*" } -- Ignore some folders on search?

-- Mouse?
vim.api.nvim_set_option('mouse', 'a')

-- set('background', 'light') -- enable light theme instead dark
-- set('shell', 'zsh') -- Your shell?

set('colorcolumn', '125') -- column length helper
set('relativenumber', true) -- relative numbers?
vim.cmd("highlight LineNr guifg=#8087a2") -- Brighter line colors?

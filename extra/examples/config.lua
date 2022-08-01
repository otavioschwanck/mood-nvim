-- Theme?
vim.cmd('colorscheme onedarkpro')

vim.g.term_as_full_screen_tabs = 1 -- full screen terminals?

-- Directory to store your notes (SPC z z)
vim.g.notes_directories = { '~/Documents/Notes' }
vim.g.ruby_debugger = "require 'pry'; binding.pry"

-- Use Alt + d instead of M to multiple cursors (only linux)
-- vim.g.multi_cursor_start_word_key      = '<A-d>'
-- vim.g.multi_cursor_next_key            = '<A-d>'

-- Function Helpers
local set = vim.api.nvim_set_option
local au = vim.api.nvim_create_autocmd
local call_term = require('helpers.user-functions').call_term
local find_in_folder = require('helpers.user-functions').find_in_folder
local wk = require("which-key")

-- Here you can set your mappings to SPC
-- Examples o = { r = { "command", "description" } } = SPC o r to call
wk.register({
  -- Example of custom terminal commands
  ["="] = { ":w | :silent !bundle exec rubocop -A %<CR>", "Rubocop on current file" },
  ["+"] = call_term('bundle exec rubocop -A', 'rubocop', 2, 0, { pre_command = ':w |' }),
  o = {
    t = {
      ":e ~/.tmux.conf<CR>", "Tmux Config"
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
    g = { ":e ~/.gitconfig<CR>", "Open Git Config" },
    z = { ":e ~/.zshrc<CR>", "Open zshrc" }
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
require("other-nvim").setup({
  mappings = {
    { pattern = "app/services/(.*)_services/(.*).rb", target = "app/contracts/%1_contracts/%2.rb" },
    { pattern = "app/contracts/(.*)_contracts/(.*).rb", target = "app/services/%1_services/%2.rb" },
    { pattern = "app/contracts/(.*)_contracts/base.rb", target = "app/services/%1_services/" },
    { pattern = "app/models/(.*).rb", target = { "app/services/%1_services/" } }
  },
})

local two_space_languages = { "ruby", "yaml", "javascript", "typescript", "typescriptreact", "javascriptreact", "eruby" }
local four_space_languages = { "solidity" }

-- autocmd array(AutoCmd, pattern, callback)
local autocommands = {
  { {"FileType"}, two_space_languages, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end },
  { {"FileType"}, four_space_languages, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end }
}

for i = 1, #autocommands, 1 do
  au(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
end


-- If you don't use pyenv or other path, please uncomment this: (Make sure that python provider is OK on :checkhealth)
-- To find where is the path of python, run which python and which python3.
-- vim.g.python_host_prog = '/usr/bin/python'
-- vim.g.python3_host_prog = '/usr/bin/python3'

-- vim.g.folder_to_ignore = [".*.git/.*", "node_modules/.*"] -- Ignore some folders on search?

-- Mouse?
vim.api.nvim_set_option('mouse', 'a')

-- set('shell', 'zsh') -- Your shell?
-- set('relativenumber', true) -- relative numbers?

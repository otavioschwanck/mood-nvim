-- Configure your per project commands.  See more at: https://github.com/otavioschwanck/tmux-awesome-manager.nvim
-- Run the per project with SPC #
require('tmux-awesome-manager').setup({
  per_project_commands = {
    api = { { cmd = 'rails s', name = 'Rails Server' } },
    front = { { cmd = 'yarn start', name = 'react server' } }
  },
  default_size = '30%',
  open_new_as = 'panel' -- change to window to open terms in new tab
})

-- Theme?
vim.cmd('colorscheme catppuccin-macchiato')

-- Directory to store your notes (SPC z z)
vim.g.notes_directories = { '~/Documents/Notes' }
vim.g.ruby_debugger = "debugger" -- can be changed to byebug or pry, call with SPC d

-- Function Helpers
local set = vim.api.nvim_set_option
local au = vim.api.nvim_create_autocmd
local find_in_folder = require('helpers.user-functions').find_in_folder
local wk = require("which-key")
local tmux = require('tmux-awesome-manager.src.term')

-- Arguments for tmux.run_wk:
--  opts.focus_when_call -- Focus terminal instead opening a enw one - default = true
--  opts.visit_first_call -- Focus the new opened window / pane. default = true
--  opts.size -- If open_as = pane, split with this size. default = 50%
--  opts.open_as -- Open as window or pane? Default: what is setted on setup (window)
--  opts.use_cwd -- Use current cwd on new window / pane? Default: what is setted on setup (true)
--  opts.close_on_timer -- When the command completed, sleep for some seconds - default = what is setted on setup: 0
--  opts.read_after_cmd -- When the command completed, wait for enter to close the window. default = true

-- Here you can set your mappings to SPC
-- Examples o = { r = { "command", "description" } } = SPC o r to call
wk.register({
  -- Example of custom terminal commands
  ["="] = { ":w | :silent !bundle exec rubocop -A %<CR>:e %<CR>", "Rubocop on current file" },
  ["+"] = tmux.run_wk({ cmd = 'bundle exec rubocop -A', name = 'rubocop', open_as = 'pane', close_on_timer = 2, visit_first_call = false, focus_when_call = false  }),
  o = {
    d = {
      name = "+Dotfiles",
      a = { ":e ~/.config/alacritty/alacritty.yml<CR>","Alacritty Config" },
      t = { ":e ~/.tmux.conf<CR>", "Tmux Config" },
      y = { ":e ~/Library/Application Support/lazygit/config.yml<CR>", "LazyGit Config" }, -- (For MAC)
      -- y = { ":e ~/.config/lazygit/config.yml<CR>" }, -- (For Linux)
      g = { ":e ~/.gitconfig<CR>", "Open Git Config" },
      z = { ":e ~/.zshrc<CR>", "Open zshrc" }
    },
    y = {
      name = "+yarn",
      i = tmux.run_wk({ cmd = 'yarn install', name = 'Yarn Install'}),
      a = tmux.run_wk({ cmd = 'yarn add %1', name = 'Yarn Add', questions = { { question = 'package name: ', required = true } } }),
      d = tmux.run_wk({ cmd = 'yarn dev', name = 'Yarn Dev'}),
    },
    r = { ":silent !bundle exec rubocop -a %<CR>", "Rubocop on current file" },
    name = "+Term Commands",
    ["1"] = tmux.run_wk({ cmd = 'docker-compose up -d', name = 'Docker Compose up' }),
    b = {
      name = "+Brownie",
      t = tmux.run_wk({ cmd = 'brownie test', name = 'Brownie Test'}),
      C = tmux.run_wk({ cmd = 'brownie compile', name = 'Brownie Compile'}),
      c = tmux.run_wk({ cmd = 'brownie console', name = 'brownie console' }),
    },
  },
  r = { -- Add your rails folders and commands here.  SPC r + key
    name = "+Rails",
    r = tmux.run_wk({ cmd = 'rails c', name = 'rails console', close_on_timer = 3 }),
    R = tmux.run_wk({ cmd = 'rails s', name = 'Rails Server', visit_first_call = false, open_as = 'window' }),
    b = tmux.run_wk({ cmd = 'bundle install', name = 'Bundle Install', open_as = 'pane', close_on_timer = 2, visit_first_call = false, focus_when_call = false }),
    g = tmux.run_wk({ cmd = 'rails generate %1', name = 'Rails Generate',  questions = { { question = "Rails generate: ", required = true, open_as = 'pane', close_on_timer = 4, visit_first_call = false, focus_when_call = false } }}),
    d = tmux.run_wk({ cmd = 'rails destroy %1', name = 'Rails Destroy', questions = { { question = "Rails destroy: ", required = true } }, open_as = 'pane', close_on_timer = 4, visit_first_call = false, focus_when_call = false}),
    i = tmux.run_wk({ cmd = 'rails db:migrate', name = 'Rails db:migrate', open_as = 'pane', close_on_timer = 4, visit_first_call = false, focus_when_call = false}),
    I = { ":call ResetRailsDb('bin/rails db:environment:set RAILS_ENV=development; rails db:drop db:create db:migrate;rails db:seed')<CR>", "Rails Reset DB" },
    m = find_in_folder('app/models', 'Find Model'),
    q = find_in_folder('app/contracts', 'Find Contracts'),
    z = find_in_folder('app/serializers', 'Find Serialiazers'),
    c = find_in_folder('app/controllers', 'Find Controller'),
    v = find_in_folder('app/views', 'Find View'),
    a = find_in_folder('config/locales', 'Find Locales'),
    u = find_in_folder('spec/factories', 'Find Factories'),
    s = find_in_folder('app/services', 'Find Services'),
    S = find_in_folder('app/business', 'Find Business'),
    n = find_in_folder('db/migrate', 'Find Migration'),
    M = { ":Emodel<CR>", "Find Model" },
    C = { ":Econtroller<CR>", "Find Controller" },
    K = { ":call KillRubyInstances()<CR>", "Kill Ruby Instances" },
    U = { ":Efixtures<CR>", "Find Current Fixture" },
    N = { ":Emigration<CR>", "Find Current Migration" },
  }
}, { prefix = "<leader>", silent = false })

local two_space_languages = { "ruby", "yaml", "javascript", "typescript", "typescriptreact", "javascriptreact", "eruby", "lua", }
local four_space_languages = { "solidity" }

-- autocmd array(AutoCmd, pattern, callback)
local autocommands = {
  { {"FileType"}, two_space_languages, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end },
  { {"FileType"}, four_space_languages, function() vim.cmd('setlocal shiftwidth=4 tabstop=4') end },
  -- { {'BufWritePre'}, {"*.tsx", "*.ts", "*.jsx", "*.js"}, function() vim.cmd("Prettier") end, }, -- prettifer on save
  -- { {'BufWritePre'}, {"*.rb"}, function() vim.lsp.buf.format { async = false, filter = function(client) return client.name == "solargraph" end } end, } -- rubocop on save
}

for i = 1, #autocommands, 1 do
  au(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
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

set('relativenumber', true) -- relative numbers?

require('core.settings').remove_bicycle_small_whells({ includeNormalMode = true })

vim.cmd("highlight LineNr guifg=#8087a2") -- Brighter line colors?
-- set('colorcolumn', '125') -- column length helper

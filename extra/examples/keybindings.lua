-- KEYBINDING ---------------------------------
-- Use this file to set your custom keybindings
-----------------------------------------------

-- Some helpers
local find_in_folder = require('helpers.user-functions').find_on_folder
local wk = require("which-key")
local tmux = require('tmux-awesome-manager.src.term')

-- Format on save
vim.g.format_on_save = true -- Configure formatter on SPC f p -> LSP

-- Arguments for tmux.run_wk:
--  opts.focus_when_call -- Focus terminal instead opening a enw one - default = true
--  opts.visit_first_call -- Focus the new opened window / pane. default = true
--  opts.size -- If open_as = pane, split with this size. default = 50%
--  opts.open_as -- Open as window or pane? Default: what is setted on setup (window)
--  opts.use_cwd -- Use current cwd on new window / pane? Default: what is setted on setup (true)
--  opts.close_on_timer -- When the command completed, sleep for some seconds - default = what is setted on setup: 0
--  opts.read_after_cmd -- When the command completed, wait for enter to close the window. default = true

-- Registering your keybindings for SPC key.
wk.add({
  { "<leader>=",   ":w | :silent !bundle exec rubocop -A %<CR>:e %<CR>",                                                                                                       desc = "Rubocop on current file", silent = false },
  { "<leader>+",   tmux.run_wk({ cmd = 'bundle exec rubocop -A', name = 'rubocop', open_as = 'pane', close_on_timer = 2, visit_first_call = false, focus_when_call = false }), desc = "rubocop",                 silent = false },

  { "<leader>o",   group = "Term Commands",                                                                                                                                    silent = false },
  { "<leader>o1",  tmux.run_wk({ cmd = 'docker-compose up -d', name = 'Docker Compose up' }),                                                                                  desc = "Docker Compose up",       silent = false },
  -- Yarn commands
  { "<leader>oy",  group = "yarn",                                                                                                                                             silent = false },
  { "<leader>oyi", tmux.run_wk({ cmd = 'yarn install', name = 'Yarn Install' }),                                                                                               desc = "Yarn Install",            silent = false },
  { "<leader>oya", tmux.run_wk({ cmd = 'yarn add %1', name = 'Yarn Add', questions = { { question = 'package name: ', required = true } } }),                                  desc = "Yarn Add",                silent = false },
  { "<leader>oyd", tmux.run_wk({ cmd = 'yarn dev', name = 'Yarn Dev' }),                                                                                                       desc = "Yarn Dev",                silent = false },

  -- Rubocop on current file
  { "<leader>or",  ":silent !bundle exec rubocop -a %<CR>",                                                                                                                    desc = "Rubocop on current file", silent = false },

  -- Brownie commands
  { "<leader>ob",  group = "Brownie",                                                                                                                                          silent = false },
  { "<leader>obt", tmux.run_wk({ cmd = 'brownie test', name = 'Brownie Test' }),                                                                                               desc = "Brownie Test",            silent = false },
  { "<leader>obC", tmux.run_wk({ cmd = 'brownie compile', name = 'Brownie Compile' }),                                                                                         desc = "Brownie Compile",         silent = false },
  { "<leader>obc", tmux.run_wk({ cmd = 'brownie console', name = 'brownie console' }),                                                                                         desc = "brownie console",         silent = false },

  -- Rails commands
  { "<leader>r",   group = "Rails",                                                                                                                                            silent = false },
  { "<leader>rr",  tmux.run_wk({ cmd = 'rails c', name = 'Rails Console', close_on_timer = 3 }),                                                                               desc = "Rails Console",           silent = false },
  { "<leader>rR",  tmux.run_wk({ cmd = 'rails s', name = 'Rails Server', visit_first_call = false, open_as = 'window' }),                                                      desc = "Rails Server",            silent = false },
  { "<leader>rb",  tmux.run_wk({ cmd = 'bundle install', name = 'Bundle Install', open_as = 'pane', close_on_timer = 2, visit_first_call = false, focus_when_call = false }),  desc = "Bundle Install",          silent = false },
  { "<leader>rg",  tmux.run_wk({ cmd = 'rails generate %1', name = 'Rails Generate', questions = { { question = "Rails generate: ", required = true } } }),                    desc = "Rails Generate",          silent = false },
  { "<leader>rd",  tmux.run_wk({ cmd = 'rails destroy %1', name = 'Rails Destroy', questions = { { question = "Rails destroy: ", required = true } } }),                       desc = "Rails Destroy",           silent = false },
  { "<leader>ri",  tmux.run_wk({ cmd = 'rails db:migrate', name = 'Rails db:migrate' }),                                                                                       desc = "Rails db:migrate",        silent = false },
  { "<leader>rI",  ":call ResetRailsDb('bin/rails db:environment:set RAILS_ENV=development; rails db:drop db:create db:migrate;rails db:seed')<CR>",                           desc = "Rails Reset DB",          silent = false },

  -- Rails file finders
  find_in_folder("<leader>rm", 'app/models', 'Find Model'),
  find_in_folder("<leader>rq", 'app/avo/resources', 'Find Avo Resources'),
  find_in_folder("<leader>rq", 'app/contracts', 'Find Contracts'),
  find_in_folder("<leader>rz", 'app/serializers', 'Find Serializers'),
  find_in_folder("<leader>rc", 'app/controllers', 'Find Controller'),
  find_in_folder("<leader>rv", 'app/views', 'Find View'),
  find_in_folder("<leader>rl", 'config/locales', 'Find Locales'),
  find_in_folder("<leader>ru", 'spec/factories', 'Find Factories'),
  find_in_folder("<leader>rs", 'app/services', 'Find Services'),
  find_in_folder("<leader>rS", 'app/business', 'Find Business'),
  find_in_folder("<leader>rM", 'db/migrate', 'Find Migration'),

  -- Miscellaneous Rails commands
  { "<leader>rM", ":Emodel<CR>",                   desc = "Find Model",             silent = false },
  { "<leader>rC", ":Econtroller<CR>",              desc = "Find Controller",        silent = false },
  { "<leader>rK", ":call KillRubyInstances()<CR>", desc = "Kill Ruby Instances",    silent = false },
  { "<leader>rU", ":Efixtures<CR>",                desc = "Find Current Fixture",   silent = false },
  { "<leader>rN", ":Emigration<CR>",               desc = "Find Current Migration", silent = false }
})

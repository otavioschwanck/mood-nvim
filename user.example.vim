" To reload your configs, press :so %

" SPC h t to see all themes

" I also recommend gruvbox
let g:catppuccin_flavour = "macchiato" " latte, frappe, macchiato, mocha
colorscheme catppuccin

" SPC z to access notes commands
let g:notes_directories = ['~/Documents/Notes']

" Your Shell?
" set shell=zsh

" set relativenumber " Relative numbers?

" Terminal full screen instead of windows?
" let g:term_as_full_screen_tabs = 1

" To install some extra plugins, visit
" ~/.config/nvim/lua/user-plugins.lua (You can press gf from the link)

" Whats is your favorite debugger?  Use with SPD d (add) and SPC D (clear all)
let g:ruby_debugger = "require 'pry'; binding.pry"

" Use Alt + d instead of m to multiple cursors
" let g:multi_cursor_start_word_key      = '<A-d>'
" let g:multi_cursor_next_key            = '<A-d>'

" let test#ruby#rspec#executable = 'foreman run rspec' " Command to run rspec, default is bundle exec rspec

" Your private mappings
lua << EOF
  local wk = require("which-key")

  -- function OpenTerm receive 4 arguments:
  -- command, name, unique and close_after_create.

  -- close_after_create can be 0 or 1
  -- unique can be 0 = Create multiple terminals, 1 = Unique, focus when use again. 2 = Unique, destroy and create a new one.

  wk.register({
    -- Example of custom terminal commands
    ["="] = { ":w | :silent !bundle exec rubocop -A %<CR>", "Rubocop on current file" },
    ["+"] = { ":w | :call OpenTerm('bundle exec rubocop -A', 'rubocop', 2, 0)<CR>", "Rubocop on entire project" },
    o = {
      t = {
        ":e ~/.tmux.conf<CR>", "Tmux Config"
      },
      y = {
        name = "+yarn",
        i = { ":call OpenTerm('yarn install', 'Yarn Install', 1, 0)<CR>", "Install" },
        a = { ":call OpenTerm('yarn add ' . input('plugin name: '), 'Yarn Add', 1, 0)<CR>", "Add" }, -- Asking for input
      },
      r = { ":silent !bundle exec rubocop -a %<CR>", "Rubocop on current file" },
      name = "+Term Commands",
      ["1"] = { ":call OpenTerm('docker-compose up -d', 'Docker Compose UP', 1, 1)<CR>", "Run Docker Compose" },
      b = {
        name = "+Brownie",
        t = { ":call OpenTerm('brownie test', 'Brownie Test', 2, 0)<CR>", "Run Tests" },
        C = { ":call OpenTerm('brownie compile', 'Brownie Compile', 2, 0)<CR>", "Compile" },
        c = { ":call OpenTerm('brownie console', 'Brownie Console', 2, 0)<CR>", "Console" },
        v = { ":call OpenTerm('brownie test ' .. fnameescape(expand('%')), 'Brownie Test Current File', 2, 0)<CR>", "Test Current File" } -- Run a command using the file name.
      },
      g = { ":e ~/.gitconfig<CR>", "Open Git Config" },
      z = { ":e ~/.zshrc<CR>", "Open zshrc" }
    },
    -- Add your rails folders and commands here
    r = {
      name = "+Rails",
      r = { ":call OpenTerm('rails c', 'Rails Console', 1, 0)<CR>", "Rails Console" },
      R = { ":call OpenTerm('rails s', 'Rails Server', 1, 1)<CR>", "Rails Server" },
      S = { ":call OpenTerm('bundle exec sidekiq', 'Sidekiq', 1, 1)<CR>", "Sidekiq" },
      b = { ":call OpenTerm('bundle install', 'Bundle Install', 1, 0)<CR>", "Bundle Install" },
      g = { ":call OpenTerm('rails generate ' . input('rails generate: '), 'Rails Generate', 2, 0)<CR>", "Rails Generate" },
      d = { ":call OpenTerm('rails destroy ' . input('rails destroy: '), 'Rails Destroy', 2, 0)<CR>", "Rails Destroy" },
      i = { ":call OpenTerm('rails db:migrate', 'migrate', 2, 0)<CR>", "Rails DB:Migrate" },
      I = { ":call OpenTerm('killall -9 rails ruby spring bundle; bin/rails db:environment:set RAILS_ENV=development; rails db:drop db:create db:migrate;rails db:seed', 'DB Reset', 2, 0)<CR>", "Rails Reset DB" },
      m = { ":call FindInFolder('app/models', 'Find Model')<CR>", "Find Model" },
      M = { ":Emodel<CR>", "Find Model" },
      c = { ":call FindInFolder('app/controllers', 'Find Controller')<CR>", "Find Controller" },
      C = { ":Econtroller<CR>", "Find Controller" },
      v = { ":call FindInFolder('app/views', 'Find View')<CR>", "Find View" },
      K = { ":call OpenTerm('killall -9 rails ruby spring bundle', 'Kill Ruby Instances', 2, 0)<CR>", "Kill Ruby Instances" },
      a = { ":call FindInFolder('config/locales', 'Find Locales')<CR>", "Find Locales" },
      u = { ":call FindInFolder('spec/factories', 'Find Factories')<CR>", "Find Factories" },
      U = { ":Efixtures<CR>", "Find Current Fixture" },
      s = { ":call FindInFolder('app/services', 'Find Services')<CR>", "Find Services" },
      V = { ":Eview <C-r>=Wildchar()<CR>", "Find views" },
      n = { ":call FindInFolder('db/migrate', 'Find Migration')<CR>", "Find Migration" },
      N = { ":Emigration<CR>", "Find Current Migration" },
      q = { ":call FindInFolder('app/contracts', 'Find Contracts')<CR>", "Find Contracts" },
      z = { ":call FindInFolder('app/serializers', 'Find Serialiazers')<CR>", "Find Serializers" },
    }
  }, { prefix = "<leader>", silent = false })
EOF

" How many spaces / tabs ?
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" 4 for javascript and other stuff?
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType solidity setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab

" If you use pyenv or other path, please comment this: (Make sure that python provider is OK on :checkhealth)
" To find where is the path of python, run which python
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" let g:folder_to_ignore = [".*.git/.*", "node_modules/.*"] " Ignore some folders on search?

" Add your vim stuff here:
set mouse=a " Mouse support ?


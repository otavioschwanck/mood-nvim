" To reload your configs, press :so %

" Select your colorscheme.  To see others: SPC h t
" I also recommend gruvbox
lua require('onedark').setup { style = 'darker' } -- Options: dark, darker, cool, deep, warm, warmer
colorscheme onedark

" To install some extra plugins, visit
" ~/.config/nvim/lua/user-plugins.lua (You can press gf from the link)

" Whats is your favorite debugger?  Use with SPD d (add) and SPC D (clear all)
let g:ruby_debugger = "byebug"

" let test#ruby#rspec#executable = 'foreman run rspec' " Command to run rspec, default is bundle exec rspec

" Your private mappings
lua << EOF
  local wk = require("which-key")

  -- function OpenTerm receive 4 arguments:
  -- command, name, unique and close_after_create.

  wk.register({
    -- Example of custom terminal commands
    ["="] = { ":silent !bundle exec rubocop -a %<CR>", "Rubocop on current file" },
    o = {
      y = {
        name = "+yarn",
        i = { ":call OpenTerm('yarn install', 'Yarn Install', 1, 0)<CR>", "Install" },
        a = { ":call OpenTerm('yarn add ' . input('plugin name: '), 'Yarn Add', 1, 0)<CR>", "Add" }, -- Asking for input
      },
      r = { ":silent !bundle exec rubocop -a %<CR>", "Rubocop on current file" },
      name = "+Term Commands",
      ["1"] = { ":call OpenTerm('Docker Compose up -d', 'Docker Compose UP', 1, 1)<CR>", "Run Docker Compose" },
      b = {
        name = "+Brownie",
        t = { ":call OpenTerm('brownie test', 'Brownie Test', 1, 0)<CR>", "Run Tests" },
        c = { ":call OpenTerm('brownie compile', 'Brownie Compile', 1, 0)<CR>", "Compile" },
        v = { ":call OpenTerm('brownie test ' .. fnameescape(expand('%')), 'Brownie Test Current File', 1, 0)<CR>", "Test Current File" } -- Run a command using the file name.
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
      i = { ":call OpenTerm('bundle install', 'Bundle Install', 1, 0)<CR>", "Bundle Install" },
      g = { ":call OpenTerm('rails generate ' . input('rails generate: '), 'Rails Generate', 1, 0)<CR>", "Rails Generate" },
      d = { ":call OpenTerm('rails destroy ' . input('rails destroy: '), 'Rails Destroy', 1, 0)<CR>", "Rails Destroy" },
      m = { ":call FindInFolder('app/models', 'Find Model')<CR>", "Find Model" },
      M = { ":Emodel<CR>", "Find Model" },
      c = { ":call FindInFolder('app/controllers', 'Find Controller')<CR>", "Find Controller" },
      C = { ":Econtroller<CR>", "Find Controller" },
      v = { ":call FindInFolder('app/views', 'Find View')<CR>", "Find View" },
      a = { ":call FindInFolder('config/locales', 'Find Locales')<CR>", "Find Locales" },
      u = { ":call FindInFolder('spec/factories', 'Find Factories')<CR>", "Find Factories" },
      s = { ":call FindInFolder('app/services', 'Find Services')<CR>", "Find Services" },
      V = { ":Eview ", "Find views" }
    }
  }, { prefix = "<leader>", silent = false })
EOF

" How many spaces / tabs ?
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" 4 for javascript and other stuff?
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype typescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype solidity setlocal ts=4 sw=4 sts=0 expandtab

" Your COC extensions.
let g:coc_global_extensions = ['coc-html', 'coc-css', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-solidity', 'coc-diagnostic', 'coc-solargraph',
      \ 'coc-emmet', 'coc-yaml', 'coc-snippets', 'coc-pyright', 'coc-solidity']

" If you use pyenv or other path, please comment this: (Make sure that python provider is OK on :checkhealth)
" To find where is the path of python, run which python
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" Add your vim stuff here:
" set mouse=a " Mouse support ?

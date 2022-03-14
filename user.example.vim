" To reload your configs, press :so %

" Select your colorscheme.  To see others: SPC h t
colorscheme gruvbox

" Your private mappings
lua << EOF
  local wk = require("which-key")

  wk.register({
    -- Example of custom terminal commands
    o = {
      r = { ":!bundle exec rubocop -a %<CR>", "Rubocop on current file" },
      name = "+Term Commands",
      ["1"] = { ":Term docker-compose up<CR>", "Run Docker Compose" },
      b = {
        name = "+Brownie",
        t = { ":Term brownie test<CR>", "Run Tests" },
        c = { ":Term brownie compile<CR>", "Compile" },
        b = { ":execute 'Term' .. ' brownie test ' .. fnameescape(expand('%:P'))<CR>", "Test Current File" } -- Run a command using the file name.
      },
      g = { ":e ~/.gitconfig<CR>", "Open Git Config" },
      z = { ":e ~/.zshrc<CR>", "Open zshrc" }
    },
    -- Add your rails folders and commands here
    r = {
      name = "+Rails",
      r = { ":Term rails console<CR>", "Rails Console" },
      R = { ":Term rails console<CR>", "Rails Server" },
      i = { ":Term bundle install<CR>", "Bundle Install" },
      m = { ":lua require'telescope.builtin'.find_files({ cwd = 'app/models' })<CR>", "Find Model" },
      c = { ":lua require'telescope.builtin'.find_files({ cwd = 'app/controllers' })<CR>", "Find Controller" },
      v = { ":lua require'telescope.builtin'.find_files({ cwd = 'app/views' })<CR>", "Find View" },
      a = { ":lua require'telescope.builtin'.find_files({ cwd = 'config/locales' })<CR>", "Find Locales" },
      u = { ":lua require'telescope.builtin'.find_files({ cwd = 'spec/factories' })<CR>", "Find Factories" },
      s = { ":lua require'telescope.builtin'.find_files({ cwd = 'app/services' })<CR>", "Find Services" },
    }
  }, { prefix = "<leader>" })
EOF

" How many spaces / tabs ?
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" 4 for javascript and other stuff?
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype typescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype solidity setlocal ts=4 sw=4 sts=0 expandtab

" Add your vim stuff here:

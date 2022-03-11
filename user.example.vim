" To reload your configs, press :so %

" Select your colorscheme.  To see others: SPC h t
colorscheme gruvbox-flat

" Your private mappings
lua << EOF
  local wk = require("which-key")

  wk.register({
    -- Example of custom terminal commands
    o = {
      name = "+Term Commands",
      ["1"] = { ":Term docker-compose up<CR>", "Run Docker Compose" },
      b = {
        name = "+Brownie",
        t = { ":Term brownie test<CR>", "Run Tests" }
        t = { ":Term brownie compile<CR>", "Run Tests" }
      },
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

" Add your vim stuff here:

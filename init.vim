function s:InstallConfigs()
  execute "!sh ~/.config/nvim/bin/setup.sh"
endfunction

command! InstallConfigs :call s:InstallConfigs()

silent :InstallConfigs

lua <<EOF
require('plugins')
EOF

runtime ./modules/settings.vim
runtime ./modules/quick-consult.vim
runtime ./modules/telescope.vim
runtime ./modules/mappings.vim
runtime ./modules/tree-sitter.vim
runtime ./modules/yanky.vim
runtime ./modules/which-key.vim
runtime ./modules/autopairs.vim

lua require("user_lsp")
lua require("lualine_config")

runtime ./user.vim

function OpenCommand()
  if &filetype == 'dashboard'
    lua require('command-on-start').autostart()
  endif
endfunction

call timer_start(4000, {-> execute("call OpenCommand()") })

lua require('notices')()


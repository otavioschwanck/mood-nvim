function s:InstallConfigs()
  execute "!sh ~/.config/nvim/bin/setup.sh"
endfunction

command! InstallConfigs :call s:InstallConfigs()

silent :InstallConfigs

runtime ./modules/plugins.vim

runtime ./modules/settings.vim
runtime ./modules/telescope.vim
runtime ./modules/mappings.vim
runtime ./modules/coc.vim
runtime ./modules/tree-sitter.vim
runtime ./modules/yanky.vim
runtime ./modules/which-key.vim
runtime ./modules/autopairs.vim
runtime ./user.vim

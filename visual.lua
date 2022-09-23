-- vim script functions
require('helpers.vim-functions').setup()
require('helpers.term-functions').setup()

require('core.plugins').setup()
require('core.set').setup()
require('core.globals').setup()
require('core.mappings').setup()

-- mood
require('mood-scripts.quick-consult').setup()

-- plugins
require('plugins.tree-sitter').setup()
require('plugins.autopairs').setup()
require('plugins.yanky').setup()

-- user
require('user.lsp')
require('user.config')

vim.cmd(":set statusline=Press\\ C-c\\ or\\ :w\\ to\\ save\\ and\\ close\\ \\|\\ Press\\ C-q\\ or\\ :cq!\\ to\\ close\\ and\\ not\\ save.")

vim.keymap.set('n', '<C-c>', '<c-o>:wall | q!<cr>')
vim.keymap.set('v', '<C-c>', ':w! | q!<cr>')
vim.keymap.set('n', '<C-q>', '<c-o>:cq!<cr>')
vim.keymap.set('v', '<C-q>', ':cq!<cr>')

vim.cmd("setlocal shiftwidth=2 tabstop=2")

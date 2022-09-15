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
require('user.debugger')

require('notify')('Press C-c or :wq to save and exit.', 'info', { title = 'mooD', timeout = 20000 })
require('notify')('Press C-k or :cq! to quit without saving..', 'info', { title = 'mooD', timeout = 20000 })

vim.keymap.set('n', '<C-c>', '<c-o>:wq<cr>')
vim.keymap.set('v', '<C-c>', ':wq<cr>')
vim.keymap.set('n', '<C-k>', '<c-o>:cq!<cr>')
vim.keymap.set('v', '<C-k>', ':cq!<cr>')

vim.cmd("setlocal shiftwidth=2 tabstop=2")

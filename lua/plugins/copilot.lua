return {
  { 'github/copilot.vim', config = function ()
    vim.keymap.set("i", "<C-f>", "<Plug>(copilot-next)", { noremap = false })
    vim.keymap.set("i", "<C-b>", "<Plug>(copilot-previous)", { noremap = false })
    vim.keymap.set("i", "<C-q>", "<Plug>(copilot-suggest)", { noremap = false })

    vim.cmd([[
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
    ]])
  end }
}

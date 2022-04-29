lua << EOF
  vim.api.nvim_set_keymap("n", "p", "<Plug>(YankyPutAfter)", {})
  vim.api.nvim_set_keymap("n", "P", "<Plug>(YankyPutBefore)", {})
  vim.api.nvim_set_keymap("x", "p", "<Plug>(YankyPutAfter)", {})
  vim.api.nvim_set_keymap("x", "P", "<Plug>(YankyPutBefore)", {})

  vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleForward)", {})
  vim.api.nvim_set_keymap("n", "<c-n>", "<Plug>(YankyCycleBackward)", {})
EOF

nnoremap gp `[v`]

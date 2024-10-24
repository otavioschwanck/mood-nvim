return {
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.cmd(
        [[
          let g:VM_leader="<leader>n"
          let g:VM_check_mappings = 0
          let g:VM_maps = {}
          let g:VM_maps['Add Cursor Down'] = '<C-j>'
          let g:VM_maps['Add Cursor Up'] = '<C-k>'
        ]]
      )
    end,
    event = "VeryLazy"
  },
}

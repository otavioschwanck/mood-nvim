return {
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_filetypes = { TelescopePrompt = false }

      vim.keymap.set('i', '<C-j>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<C-f>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<C-b>', function() return vim.fn['codeium#CycleCompletions']( -1) end, { expr = true })
      vim.keymap.set('i', '<C-]>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  }
}

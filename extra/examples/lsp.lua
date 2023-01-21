local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'solargraph',
  'jsonls',
  'solidity'
})

lsp.configure('solidity', {
  settings = {
    solidity = { includePath = '',
      remapping = { ["@OpenZeppelin/"] = 'dependencies/OpenZeppelin/openzeppelin-contracts@4.6.0/' } }
  }
})

lsp.nvim_workspace()

local sources = require('lsp-zero').defaults.cmp_sources()

table.insert(sources, { name = "calc" }) -- adding cmp-calc.  Try to type 3 + 3 and see what happens.

lsp.setup_nvim_cmp({
  sources = sources
})

lsp.setup()


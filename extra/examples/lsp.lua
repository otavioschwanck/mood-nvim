  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vs-snippets" } })

  local lsp = require('lsp-zero')

  lsp.preset('recommended')

  local cmp = require('cmp')
  local luasnip = require("luasnip")

  local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-d>'] = cmp.mapping(function (fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
  })

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
      solidity = { includePath = '', remapping = { ["@OpenZeppelin/"] = 'dependencies/OpenZeppelin/openzeppelin-contracts@4.6.0/' } }
    }
  })

  lsp.nvim_workspace()

  local sources = require('lsp-zero').defaults.cmp_sources()

  table.insert(sources, { name = "calc" })

  lsp.setup_nvim_cmp({
    sources = sources,
    mapping = cmp_mappings
  })

  lsp.setup()

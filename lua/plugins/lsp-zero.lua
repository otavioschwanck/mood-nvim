return { { 'VonHeikemen/lsp-zero.nvim', dependencies = {
  { 'neovim/nvim-lspconfig' }, -- Required
  { 'williamboman/mason.nvim' }, -- Optional
  { 'hrsh7th/cmp-calc' },
  { 'williamboman/mason-lspconfig.nvim' }, -- Optional
  -- Autocompletion
  { 'hrsh7th/nvim-cmp' }, -- Required
  { 'hrsh7th/cmp-nvim-lsp' }, -- Required
  { 'hrsh7th/cmp-buffer' }, -- Optional
  { 'hrsh7th/cmp-path' }, -- Optional
  { 'saadparwaiz1/cmp_luasnip' }, -- Optional
  { 'hrsh7th/cmp-nvim-lua' }, -- Optional
  { 'jose-elias-alvarez/null-ls.nvim' },

  -- Snippets
  { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" }, -- Required
  { 'rafamadriz/friendly-snippets' }, -- Optional
}, config = function()
  require("user.lsp")
  })
end } }

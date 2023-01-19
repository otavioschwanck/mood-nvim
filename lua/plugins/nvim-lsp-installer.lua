return {
  {
    "williamboman/nvim-lsp-installer",
    dependencies = { "neovim/nvim-lspconfig", 'hrsh7th/nvim-cmp', { 'quangnguyen30192/cmp-nvim-ultisnips', dependencies = { 'SirVer/ultisnips' } } },
    config = function()
      require("nvim-lsp-installer").setup({
        automatic_installation = { exclude = { "solargraph", "sorbet" } },
        ui = {
          icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
          }
        }
      })
    end
  }
}

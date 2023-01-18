return {
  {
    "williamboman/nvim-lsp-installer",
    dependencies = { "neovim/nvim-lspconfig", config = function()
	pcall(require, 'user.lsp')
    end},
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

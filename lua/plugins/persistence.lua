return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function ()
      require("persistence").setup({
        options = {'buffers', 'curdir', 'globals', 'tabpages', 'winsize'},
      })

      require("mood-scripts.auto-save-session").setup()

      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = vim.api.nvim_create_augroup("persistence_pre_save", { clear = true }),
        callback = function ()
          vim.cmd("doautocmd User SessionSavePre")
          require('persistence').save()
        end
      })
    end
  }
}

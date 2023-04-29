return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function ()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
        options = {'buffers', 'curdir', 'globals', 'tabpages', 'winsize'},
        pre_save = function() vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' }) end,
      })

      require("mood-scripts.auto-save-session").setup()
    end
  }
}

return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function ()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
        options = {'buffers', 'curdir', 'globals', 'tabpages', 'winsize'},
      })
    end
  }
}

return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup({
        options = { "buffers", "curdir", "tabpages", "winsize", "globals" },
      })
    end,
  }
}

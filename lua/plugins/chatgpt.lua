return {
  {
    "jackMort/ChatGPT.nvim",
    keys = {
      { "<leader>i", "<cmd>ChatGPT<CR>", desc = "ChatGPT" }
    },
    config = function()
      require("chatgpt").setup({
        welcome_message = "",

      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}

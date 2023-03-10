return {
  {
    "jackMort/ChatGPT.nvim",
    keys = {
      { "<leader>i", "<cmd>ChatGPT<CR>", desc = "ChatGPT" }
    },
    config = function()
      require("chatgpt").setup({
        welcome_message = "",
        keymaps = {
          close = { "<C-c>" },
          submit = "<C-s>",
          yank_last = "<C-y>",
          scroll_up = "<C-u>",
          scroll_down = "<C-d>",
          toggle_settings = "<C-o>",
          new_session = "<C-n>",
          cycle_windows = "<Tab>",
          -- in the Sessions pane
          select_session = "<Space>",
          rename_session = "r",
          delete_session = "d",
        },
      })
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}

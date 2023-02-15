return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
      { "<leader>bk", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bK", "<Cmd>BufferLineGroupClose ungrouped<CR><Cmd>BufferLineGroupClose pinned<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bn", ":e ~/.nvim-scratch<CR>",                  desc = "Open Scratch Buffer" },
      { "<C-s>",         "<cmd>BufferLineTogglePin<cr>",            desc = "Prev Buffer" },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
      { "H",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      { "L",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
      { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Switch Prev Buffer" },
      { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Switch Next Buffer" },
      { "<C-h>",         "<cmd>BufferLineMovePrev<cr>",             desc = "Switch Prev Buffer" },
      { "<C-l>",         "<cmd>BufferLineMoveNext<cr>",             desc = "Switch Next Buffer" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  }
}

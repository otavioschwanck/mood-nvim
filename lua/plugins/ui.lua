return {
  {
    "romgrk/barbar.nvim",
    lazy = true,
    keys = {
      { "<leader>bp", "<Cmd>BufferPin<CR>",                desc = "Toggle pin" },
      { "<leader>bk", "<Cmd>BufferCloseAllButPinned<CR>",  desc = "Delete non-pinned buffers" },
      { "<leader>k",  "<Cmd>BufferClose<CR>",              desc = "Close Buffer" },
      { "<leader>bK", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Kill all buffers except current" },
      { "<leader>k",  "<Cmd>BufferClose<CR>",              desc = "Close Buffer" },
      { "<leader>bn", ":e ~/.nvim-scratch<CR>",            desc = "Open Scratch Buffer" },
      { "<C-q>",      "<cmd>BufferPick<cr>",               desc = "Pick Buffer" },
      { "<C-s>", function()
        vim.cmd("BufferPin")
        require("mood-scripts.auto-save-session").save_session({ file = "yeees" })
      end, desc = "Pin Buffer" },
      { "[b",    "<cmd>BufferPrevious<cr>",     desc = "Prev Buffer" },
      { "]b",    "<cmd>BufferNext<cr>",         desc = "Next Buffer" },
      { "H",     "<cmd>BufferPrevious<cr>",     desc = "Prev Buffer" },
      { "L",     "<cmd>BufferNext<cr>",         desc = "Next Buffer" },
      { "[B",    "<cmd>BufferMovePrevious<cr>", desc = "Switch Prev Buffer" },
      { "]B",    "<cmd>BufferMoveNext<cr>",     desc = "Switch Next Buffer" },
      { "<C-h>", "<cmd>BufferMovePrevious<cr>", desc = "Switch Prev Buffer" },
      { "<C-l>", "<cmd>BufferMoveNext<cr>",     desc = "Switch Next Buffer" },
    },
  }
}

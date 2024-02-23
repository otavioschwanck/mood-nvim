return {
  {
    "roobert/search-replace.nvim",
    event = "VeryLazy",
    config = function()
      require("search-replace").setup({})

      local opts = {}

      local get_selected_lines_count = function()
        local start_line = vim.fn.getpos("v")[2]
        local end_line = vim.fn.getpos(".")[2]

        return math.abs(end_line - start_line) + 1
      end

      local call_visual_command = function()
        local current_mode = vim.fn.mode()
        local number_of_lines_selected_in_visual_mode = get_selected_lines_count()

        if (current_mode == "V" or current_mode == "<C-V>") and number_of_lines_selected_in_visual_mode == 1 then
          vim.cmd("SearchReplaceSingleBufferCWord")
        elseif current_mode == "V" or current_mode == "<C-V>" then
          vim.cmd("SearchReplaceWithinVisualSelection")
        else
          vim.cmd("SearchReplaceSingleBufferVisualSelection")
        end
      end

      vim.keymap.set("x", "gq", call_visual_command, opts)

      vim.api.nvim_set_keymap("n", "gq", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts)
      vim.api.nvim_set_keymap("n", "gQ", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts)
    end,
  },
}

return {
  {
    'rmagatti/goto-preview',
    keys = {
      { 'gp', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', desc = "Preview Definition", mode = 'n' },
      { 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>', mode = 'n', desc = "Close all preview windows" },

    },
    config = function()
      require('goto-preview').setup {
        height = 23;
      }
    end
  },
}

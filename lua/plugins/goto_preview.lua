return {
  {
    'rmagatti/goto-preview',
    keys = {
      { 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', desc = "Preview Definition", mode = 'n' },
      { 'gpt', '<cmd>lua require("goto-preview").goto_preview_type_definition()<CR>', mode = 'n', desc = "Preview Type Definition" },
      { 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', mode = 'n', desc = "Preview Implementation" },
      { 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>', mode = 'n', desc = "Close all preview windows" },
      { 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', mode = 'n', desc = "Preview References" },

    },
    config = function()
      require('goto-preview').setup {
        height = 23;
      }
    end
  },
}

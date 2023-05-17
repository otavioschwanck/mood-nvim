return {
  {
    'ThePrimeagen/harpoon',
    config = function ()
      require('harpoon').setup(
        {
          tabline = true
        }
      )
    end,
    keys = {
      { ';',     '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = 'Harpoon menu' },
      { '<C-s>', '<cmd>lua require("harpoon.mark").toggle_file()<cr>',                                           desc = 'Pin on Harpoon' },
    }
  }
}

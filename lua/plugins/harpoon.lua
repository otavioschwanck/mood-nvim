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
      { '<C-s>', '<cmd>lua require("harpoon.mark").toggle_file()<cr>redrawt<cr>', desc = 'Pin on Harpoon' },
    }
  }
}

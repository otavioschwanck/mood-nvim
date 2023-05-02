local function save_or_remove()
  if require('harpoon.mark').get_index_of(vim.fn.bufname()) then
    require("harpoon.mark").rm_file()
  else
    require("harpoon.mark").add_file()
  end
end

return {
  {
    'ThePrimeagen/harpoon',
    opts = {},
    keys = {
      {';', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = 'Harpoon menu' },
      { '<C-s>', save_or_remove, desc = 'Pin on Harpoon' },
    }
  }
}

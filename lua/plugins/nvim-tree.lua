return {
  { 'kyazdani42/nvim-web-devicons', config = function()
    require 'nvim-web-devicons'.setup {
      override = {
        rb = {
          icon = "",
          color = "#ff8587",
          cterm_color = "65",
          name = "Ruby"
        }
      }
    }
  end },
  { 'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' }, config = function()
    vim.cmd([[ highlight NvimTreeIndentMarker guifg=#957FB8 ]])
    vim.cmd([[highlight Beacon guibg=#957FB8 ctermbg=15]])

    require("nvim-tree").setup({
      update_cwd = false,
      renderer = {
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = ""
            }
          }
        },
      },
      view = {
        adaptive_size = true,
        hide_root_folder = true,
        mappings = {
          custom_only = false,
        },
      }
    })
  end }
}

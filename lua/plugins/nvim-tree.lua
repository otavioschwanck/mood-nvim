local M = {}

function M.setup()
  vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

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
end

return M

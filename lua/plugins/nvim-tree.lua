local M = {}

function M.setup()
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
end

return M

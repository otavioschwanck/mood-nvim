local M = {}

function M.setup()
  require("nvim-tree").setup({
    update_cwd = false,
    view = {
      hide_root_folder = true,
      mappings = {
        custom_only = false,
      },
    }
  })
end

return M

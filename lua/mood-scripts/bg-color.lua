local M = {}

local fn = vim.fn

local function get_color(group, attr)
    return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

function M.setup()
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      local id = vim.api.nvim_create_augroup("BgColorChange", { clear = true })

      local bg = get_color('Normal', 'bg#')

      vim.api.nvim_create_autocmd('FocusGained', {
        pattern = '*',
        callback = function()
          vim.cmd("highlight Normal guibg=" .. bg)
        end,
        group = 'BgColorChange'
      })

      vim.api.nvim_create_autocmd('FocusLost', {
        pattern = '*',
        callback = function(args)
          vim.cmd("highlight Normal guibg=black")
        end,
        group = 'BgColorChange'
      })
    end,
  })
end

return M

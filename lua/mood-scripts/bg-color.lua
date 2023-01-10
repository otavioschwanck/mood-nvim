local M = {}

local fn = vim.fn

local function get_color(group, attr)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

function M.normalize_return(str)
  local str = string.gsub(str, "\n", "").gsub(str, " ", "")

  return str
end

local function change()
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
      local count_cmd = M.normalize_return(vim.fn.system("tmux list-panes | wc -l"))
      local maximizedCmd = M.normalize_return(vim.fn.system("tmux list-panes -F '#F'"))

      if (tonumber(count_cmd) or 1) > 1 and not(string.match(maximizedCmd, "Z")) then
        vim.cmd("highlight Normal guibg=black")
      end
    end,
    group = 'BgColorChange'
  })
end

local function change_func()
  pcall(change)
end

function M.setup()
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = change_func,
  })
end

return M

local M = {}

local fn = vim.fn

function M.window_id()
  return vim.g.tmux_window_id or M.normalize_return(vim.fn.system("tmux display-message -p '#I'")) or "1"
end

local function get_color(group, attr)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

function M.normalize_return(str)
  local str = string.gsub(str, "\n", "")
  str = str.gsub(str, " ", "")

  return str
end

local function set_win_stuff()
  M.winhighlight = get_color('winhighlight', 'bg#')

  vim.cmd("hi ActiveWindow guibg=#" .. M.winhighlight)
  vim.cmd("hi InactiveWindow guibg=#292c41")
end

local function call_blink()
  if not M.winhighlight then
    set_win_stuff()
  end

  local win_id = vim.fn.win_getid()

  vim.fn.setwinvar(win_id, "&winhighlight", "Normal:InactiveWindow")

  vim.fn.timer_start(100, function()
    vim.fn.setwinvar(win_id, "&winhighlight", "Normal:ActiveWindow")
  end)
end

local function blink()
  local count_cmd = M.normalize_return(vim.fn.system("tmux list-panes -t " .. M.window_id() .. " | wc -l"))

  if tonumber(count_cmd) > 1 or require("utils.buf_count")() > 1 then
    call_blink()
  end
end

function M.setup()
  vim.api.nvim_create_autocmd('FocusGained', {
    pattern = '*',
    callback = blink,
  })

  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = set_win_stuff,
  })

  set_win_stuff()
end

M.setup()

return M

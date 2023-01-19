local M = {}

local fn = vim.fn

local function get_color(group, attr)
  return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
end

function M.normalize_return(str)
  local str = string.gsub(str, "\n", "")
  str = str.gsub(str, " ", "")

  return str
end

local function Split(s, delimiter)
  local result = {};

  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

function M.set_variables()
  vim.g.tmux_window_id = M.normalize_return(vim.fn.system("tmux display-message -p '#I'"))
end

function M.window_id()
  return vim.g.tmux_window_id or M.normalize_return(vim.fn.system("tmux display-message -p '#I'")) or "1"
end

function M.current_is_the_active()
  local count_cmd = Split(vim.fn.system("tmux list-panes -t " .. M.window_id() .. " -F '#{pane_active} #{pane_id}'"), "\n")
  local focused

  for i=1,#count_cmd, 1 do
    if string.sub(count_cmd[i], 1, 1) == "1" then
      focused = count_cmd[i]
    end
  end

  return string.sub(focused, 3, #focused) == vim.g.tmux_pane_id
end

local function change()
  local id = vim.api.nvim_create_augroup("BgColorChange", { clear = true })

  local bg = get_color('Normal', 'bg#')

  vim.g.tmux_pane_id = M.normalize_return(vim.fn.system("tmux display -pt \"${TMUX_PANE:?}\" '#{pane_id}'"))

  M.set_variables()

  vim.api.nvim_create_autocmd('FocusGained', {
    pattern = '*',
    callback = function()
      M.set_variables()
      vim.cmd("highlight Normal guibg=" .. bg)
    end,
    group = 'BgColorChange'
  })

  vim.api.nvim_create_autocmd('FocusLost', {
    pattern = '*',
    callback = function(args)
      local count_cmd = M.normalize_return(vim.fn.system("tmux list-panes -t " .. M.window_id() .. " | wc -l"))
      local maximizedCmd = M.normalize_return(vim.fn.system("tmux list-panes -t " .. M.window_id() .. " -F '#F'"))
      local focused = M.normalize_return("tmux display -pt \"${TMUX_PANE:?}\" '#{pane_id}'")

      if (tonumber(count_cmd) or 1) > 1 and not(string.match(maximizedCmd, "Z")) and not(M.current_is_the_active()) then
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

  change_func()
end

return M

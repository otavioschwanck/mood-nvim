local M = {}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.normalize_return(str)
  local str = string.gsub(str, "\n", "")

  str = str.gsub(str, " ", "")

  return str
end

function M.go_to_next()
  local is_last_window = vim.fn.winnr() == #vim.api.nvim_list_wins()

  local pane_count = tonumber(vim.fn.system("tmux display-message -p '#{window_panes}' "))
  local window_id = M.normalize_return(vim.fn.system("tmux display-message -p '#I'"))
  local is_maximized = M.normalize_return(vim.fn.system("tmux list-panes -t " .. window_id .. " -F '#F'"))

  if is_last_window and pane_count and pane_count > 1 and not(string.match(is_maximized, "Z")) then
    vim.fn.system("tmux select-pane -t :.+")
  else
    vim.cmd(t("norm! <C-w>w"))
  end
end

function M.go_to_prev()
  local is_first_window = vim.fn.winnr() == 1
  local pane_count = tonumber(vim.fn.system("tmux display-message -p '#{window_panes}' "))
  local window_id = M.normalize_return(vim.fn.system("tmux display-message -p '#I'"))
  local is_maximized = M.normalize_return(vim.fn.system("tmux list-panes -t " .. window_id .. " -F '#F'"))

  if is_first_window and pane_count and pane_count > 1 and not(string.match(is_maximized, "Z")) then
    vim.fn.system("tmux select-pane -t :.-")
  else
    vim.cmd(t("norm! <C-w>W"))
  end
end

return M


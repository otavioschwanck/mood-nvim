local function osExecute(cmd)
  local fileHandle     = assert(io.popen(cmd, 'r'))
  local commandOutput  = assert(fileHandle:read('*a'))
  local returnTable    = {fileHandle:close()}
  return commandOutput,returnTable[3]
end

local function Split(s, delimiter)
  local result = {};

  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

local function restart_all()
  local tmux_windows = Split(osExecute('tmux list-window -F "#I"'), "\n")
  table.remove(tmux_windows, #tmux_windows)

  for __, number in ipairs(tmux_windows) do
    osExecute('tmux send-keys -t ' .. number .. ' C-\\\\ C-n')
    osExecute('tmux send-keys -t ' .. number .. ' " #"')
  end
end

return {
  restart_all = restart_all,
}

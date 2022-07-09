local notify = require('notify')

local function start()
  local commands = vim.g.commands_for_autostart or {}
  local p_name = vim.fn.split(vim.fn.finddir('.git/..', vim.fn.expand('%:p:h') .. ';'), "/")

  if vim.fn.len(p_name) > 0 then
    p_name = p_name[vim.fn.len(p_name)]
  end

  local commands_for_project = commands[p_name]

  if not commands_for_project then
    return
  end

  for _index, value in ipairs(commands_for_project) do
    vim.cmd("call OpenTerm('" .. value[1] .. "', '" .. value[2] .. "', 2, 1)")
  end
end

local filter = vim.tbl_filter

local function map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

local function contains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

local function find_terminals(p_name, terminals)
  local term_names = map(terminals, function(item) return p_name .. " " .. item[2] end)

  local bufnrs = filter(function(b)
    if not (vim.fn.getbufvar(b, '&buftype', 'ERROR') == 'terminal') then
      return false
    end

    if not contains(term_names, vim.fn.bufname(b)) then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  return bufnrs
end

local function Split(s, delimiter)
  local result = {};

  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

local function osExecute(cmd)
  local fileHandle     = assert(io.popen(cmd, 'r'))
  local commandOutput  = assert(fileHandle:read('*a'))
  local returnTable    = {fileHandle:close()}
  return commandOutput,returnTable[3]            -- rc[3] contains returnCode
end

local function restart_all()
  local tmux_windows = Split(osExecute('tmux list-window -F "#I"'), "\n")
  table.remove(tmux_windows, #tmux_windows)

  for index, number in ipairs(tmux_windows) do
    osExecute('tmux send-keys -t ' .. number .. ' C-\\\\ C-n')
    osExecute('tmux send-keys -t ' .. number .. ' " #"')
  end
end

local function restart()
  local commands = vim.g.commands_for_autostart or {}
  local p_name = vim.fn.split(vim.fn.finddir('.git/..', vim.fn.expand('%:p:h') .. ';'), "/")

  if vim.fn.len(p_name) > 0 then
    p_name = p_name[vim.fn.len(p_name)]
  end

  local commands_for_project = commands[p_name]

  if commands_for_project then
    local terminals = find_terminals(p_name, commands_for_project)

    local all_closed = false

    for key, buf in pairs(terminals) do
      local channel = vim.fn.getbufvar(buf, '&channel')

      vim.fn.jobstop(channel)
    end

    if #terminals > 0 then
      notify('Closing Initial Terminals...', 'info', { title='Terminal Management' })
    end

    repeat
      all_closed = true

      for key, buf in pairs(terminals) do
        local channel = vim.fn.getbufvar(buf, '&channel')

        if vim.fn.jobwait({channel}, 0)[1] == -3 then
          vim.cmd("bdelete! " .. buf)
        else
          all_closed = false
        end
      end

      if all_closed then
        start()
      end
    until all_closed
  else
    notify("This project doesn't have any startup terminals configured...", 'warn', { title='Terminal Management' })
  end
end

local function autostart()
  if vim.g.disable_autostart_commands == 0 then
    vim.g.disable_autostart_commands = 1

    start()
  end
end

return { autostart = autostart, restart = restart, restart_all = restart_all }

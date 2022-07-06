vim.g.started = 0

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

local function autostart()
  if vim.g.started == 0 then
    vim.g.started = 1

    start()
  end
end

return { autostart = autostart, start = start }

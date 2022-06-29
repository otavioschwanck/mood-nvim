local function run_auto_start_command()
  local commands = vim.g.commands_for_autostart or {}
  local p_name = vim.fn.split(vim.fn.finddir('.git/..', vim.fn.expand('%:p:h') .. ';'), "/")

  if vim.fn.len(p_name) > 0 then
    p_name = p_name[vim.fn.len(p_name)]
  end

  local commands_for_project = commands[p_name]

  if not commands_for_project then
    return
  end

  for index, value in ipairs(commands_for_project) do
    vim.cmd(value)
  end
end

return run_auto_start_command

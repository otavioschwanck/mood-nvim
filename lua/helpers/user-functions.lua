local M = {}

function M.call_term(command, title, unique, close_after_create, term_opts)
  local opts = term_opts or {}

  local pre = opts.pre_command or ''

  if opts.input then
    command = command .. " ' . " .. 'input("' .. opts.input .. '")'
  else
    command = command .. "'"
  end

  return { pre ..
  "<cmd>call OpenTerm('" .. command .. ", '" .. title .. "', " .. unique .. ", " .. close_after_create .. ")<CR>", title }
end

function M.find_in_folder(folder, title)
  return { "<cmd>call FindInFolder('" .. folder .. "', '" .. title .. "')<CR>", title }
end

function M.find_on_folder(command, folder, title)
  return { command, "<cmd>call FindInFolder('" .. folder .. "', '" .. title .. "')<CR>", desc = title }
end

return M

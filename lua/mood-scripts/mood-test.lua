local M = {}

function M.is_in_spec()
  local current_file_name = vim.fn.fnamemodify(vim.fn.expand("%:t"), ":~:.")

  return vim.o.filetype == "ruby" and string.match(current_file_name, "_spec")
end

function M.run_nearest()
  if M.is_in_spec() and not vim.g.use_tmux_for_tests then
    require('ror.test').run('Line')
  else
    vim.cmd("TestNearest")
  end
end

function M.run_file()
  if M.is_in_spec() and not vim.g.use_tmux_for_tests then
    require('ror.test').run()
  else
    vim.cmd("TestNearest")
  end
end

return M

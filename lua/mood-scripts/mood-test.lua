local M = {}

function M.is_in_spec()
  local current_file_name = vim.fn.fnamemodify(vim.fn.expand("%:t"), ":~:.")

  return vim.o.filetype == "ruby" and string.match(current_file_name, "_spec")
end

function M.run_nearest()
  if M.is_in_spec() and not vim.g.use_tmux_for_tests then
    require('ror.test').run('Line')

    vim.g.last_is_tmux = false
  else
    vim.cmd("TestNearest")

    vim.g.last_is_tmux = true
  end
end

function M.run_file()
  if M.is_in_spec() and not vim.g.use_tmux_for_tests then
    require('ror.test').run()

    vim.g.last_is_tmux = false
  else
    vim.cmd("TestFile")

    vim.g.last_is_tmux = true
  end
end

function M.only_failures()
  if not(vim.g.use_tmux_for_tests) and not(vim.g.last_is_tmux) then
    require('ror.test').run('OnlyFailures')

    vim.g.last_is_tmux = false
  else
    vim.cmd("RSpec --only-failures --format documentation")

    vim.g.last_is_tmux = true
  end
end

function M.rerun()
  if not vim.g.use_tmux_for_tests and not(vim.g.last_is_tmux) then
    require('ror.test').run('Last')

    vim.g.last_is_tmux = false
  else
    vim.cmd("TestLast")

    vim.g.last_is_tmux = true
  end
end

return M

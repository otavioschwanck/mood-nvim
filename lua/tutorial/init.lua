local M = {}

local exerciseComment = 'Exercise \\d'
local exerciseStart = '# << Start'

function M.start(ignore_notification)
  vim.cmd("silent !cp ~/.config/nvim/extra/tutorial.rb ~/.tutorial.rb")
  vim.cmd("silent e ~/.tutorial.rb")

  if not ignore_notification then
    require('notify')("Welcome to mood nvim editing Tutorial.", 'info', { title='mooD Nvim' })
  end

  M.define_mappings()

  vim.cmd('norm! gg')
end

function M.jump()
  local exercise_count = vim.fn.input('Jump to exercise (input the number): ')

  vim.cmd("norm gg")

---@diagnostic disable-next-line: unused-local
  for __ = 1, exercise_count, 1 do
    M.next_exercise()
  end
end

function M.define_mappings()
  local bufnr = vim.fn.bufnr('.tutorial.rb')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  vim.keymap.set('n', '<C-j>', M.next_exercise, bufopts)
  vim.keymap.set('n', '<C-K>', M.prev_exercise, bufopts)

  vim.keymap.set('n', 'zj', M.next_exercise, bufopts)
  vim.keymap.set('n', 'zk', M.prev_exercise, bufopts)
  vim.keymap.set('n', 'zJ', M.jump, bufopts)

  vim.keymap.set('n', 'zr', M.reset_exercise, bufopts)
end

function M.reset_exercise()
  local line_number = vim.fn.line('.')

  vim.cmd("w")
  M.start(true)

  vim.cmd('' .. line_number)

  vim.fn.search(exerciseComment, 'b')
  vim.fn.search(exerciseStart)
  vim.cmd("norm 0")

  M.define_mappings()

  vim.cmd("norm zb\\<C-e>\\<C-e>")
end

function M.next_exercise()
  vim.fn.search(exerciseComment)
  vim.fn.search(exerciseStart)
  vim.cmd("norm zb\\<C-e>\\<C-e>")
  vim.cmd("norm 0")
end

function M.prev_exercise()
  vim.fn.search(exerciseComment, 'b')
  vim.fn.search(exerciseStart, 'b')
  vim.cmd("norm zb\\<C-e>\\<C-e>")
  vim.cmd("norm 0")
end

return M

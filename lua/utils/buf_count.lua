local function buf_count()
  local win_count = vim.fn.winnr('$')

  local buffers = {}

  for i = 1, win_count, 1 do
    table.insert(buffers, vim.fn.winbufnr(i))
  end

  local real_buffers = {}

  for i = 1, #buffers, 1 do
    if (vim.fn.getbufvar(buffers[i], '&buftype', 'ERROR') == 'terminal' or vim.fn.getbufvar(buffers[i], '&filetype', 'ERROR'))
    and vim.fn.bufname(buffers[i]) ~= '' then
      table.insert(real_buffers, buffers[i])
    end
  end

  return #real_buffers
end

return buf_count

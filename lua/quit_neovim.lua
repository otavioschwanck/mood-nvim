local filter = vim.tbl_filter

local function find_terminals()
  local bufnrs = filter(function(b)
    if not (vim.fn.getbufvar(b, '&buftype', 'ERROR') == 'terminal') then
    return false
  end

    if string.find(vim.fn.bufname(b), ':lazygit') then
    return false
  end

    return true
  end, vim.api.nvim_list_bufs())

  return bufnrs
end

local function quit_neovim()
  local bufnrs = find_terminals()

  for key, buf in pairs(bufnrs) do
    local channel = vim.fn.getbufvar(buf, '&channel')

    vim.fn.jobstop(channel)
  end

  local all_closed = false

  if #bufnrs == 0 then
    vim.cmd("qall")
  end

  repeat
    all_closed = true

    for key, buf in pairs(bufnrs) do
      local channel = vim.fn.getbufvar(buf, '&channel')

      if not vim.fn.jobwait({channel}, 0)[1] == -3 then
        all_closed = false
      end

      if all_closed then
        vim.cmd("qall")
      end
    end
  until all_closed
end

return quit_neovim

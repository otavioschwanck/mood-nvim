local filter = vim.tbl_filter

local function map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end

    return t
end

local function last_visited_terminal()
  local bufnrs = filter(function(b)
    if not (vim.fn.getbufvar(b, '&buftype', 'ERROR') == 'terminal') then
            return false
    end

    if string.find(vim.fn.bufname(b), ':lazygit') then
            return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  local times = map(bufnrs, function(item) return vim.fn.getbufvar(item, 'visit_time') end)

  if #times > 0 then
    local lowerTime = 9999999999999
    local lowerId = 0

    for i = 1, #times, 1 do
      local cur_time = times[i] or 0

      if cur_time <= lowerTime then
        lowerTime = cur_time
        lowerId = i
      end
    end

    return bufnrs[lowerId]
  else
    return 0
  end
end

return last_visited_terminal

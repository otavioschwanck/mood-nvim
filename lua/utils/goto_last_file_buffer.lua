local filter = vim.tbl_filter

local function map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end

    return t
end

local function goto_last_file_buffer()
  local bufnrs = filter(function(b)
    if vim.fn.getbufvar(b, '&filetype', 'ERROR') == '' then
      return false
    end

    if not vim.fn.buflisted(b) == 1 then
      return false
    end

    if vim.fn.bufname(b) == '' then
      return false
    end

    return true
 end, require('utils.valid_listed_buffers')())

  local times = map(bufnrs, function(item) return vim.fn.getbufvar(item, 'visit_time') or nil end)

  if #bufnrs > 0 then
    if #times > 0 then
      local higherTime = 0
      local higherId = 0

      for i = 1, #times, 1 do
        local cur_time = times[i]

        if cur_time == '' or not cur_time then
          cur_time = 1
        end

        if cur_time > higherTime then
          higherTime = cur_time
          higherId = i
        end
      end

      vim.cmd("b " .. bufnrs[higherId])
    end
  else
    vim.cmd("tabnew")
  end
end

return goto_last_file_buffer

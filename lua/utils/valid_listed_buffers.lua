local function return_listed_valid_buffers()
  local buffers = vim.api.nvim_list_bufs()
  local buffersToUse = {}
  local bufferIndex = 1

  for i=1,#buffers,1 do
    local buf = buffers[i]
    local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))

    local buf_type = vim.fn.getbufvar(buf, '&buftype', 'ERROR')

    if not (byte_size > 1024 * 128) and (vim.fn.buflisted(buf) == 1 or buf_type == 'terminal' or buf_type == 'nofile') then -- 1 Megabyte max
      buffersToUse[bufferIndex] = buf
      bufferIndex = bufferIndex + 1
    end
  end

  return buffersToUse
end

return return_listed_valid_buffers

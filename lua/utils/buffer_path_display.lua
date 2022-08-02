local buffer_path_display = function(opts, path)
  local tail = require("telescope.utils").path_tail(path)
  local split = require('utils.table_functions').Split

  local splitted_tail = split(path, '/')

  local path_name = ''

  if #splitted_tail >= 2 then
    for i = 1, #splitted_tail - 1, 1 do
      if i < #splitted_tail - 1 then
        path_name = path_name .. '/' .. splitted_tail[i]:sub(1,2)
      else
        path_name = path_name .. '/' .. splitted_tail[i]
      end
    end
  else
    path_name = '/'
  end

  return string.format("%s |  %s", tail, path_name)
end

return buffer_path_display

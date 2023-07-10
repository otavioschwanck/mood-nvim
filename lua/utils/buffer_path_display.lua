local buffer_path_display = function(opts, path)
  local tail = require("telescope.utils").path_tail(path)
  local split = require('utils.table_functions').Split

  local splitted_tail = split(path, '/')

  local path_name = ''

  if #splitted_tail >= 2 then
    for i = 1, #splitted_tail - 1, 1 do
      if i < #splitted_tail - 1 then
        path_name = path_name .. '/' .. splitted_tail[i]
      else
        path_name = path_name .. '/' .. splitted_tail[i]
      end
    end
  else
    path_name = '/'
  end

  local displayer =  require("telescope.pickers.entry_display").create({
    separator = " ",
    items = {
      { width = 80 },
      { remaining = true }
    }
  })

  return displayer({ { tail, "File" }, { path_name:sub(2, #path_name), "Path" } })
end

return buffer_path_display

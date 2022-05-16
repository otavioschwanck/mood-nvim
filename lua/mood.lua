function filter_inplace(arr, func)
    local new_index = 1
    local size_orig = #arr
    for old_index, v in ipairs(arr) do
        if func(v, old_index) then
            arr[new_index] = v
            new_index = new_index + 1
        end
    end
    for i = new_index, size_orig do arr[i] = nil end
end

function add_byebug()
  local error = vim.diagnostic.get()[1]
  local line = vim.fn.line(".")

  print(vim.inspect(error))
end

return add_byebug()

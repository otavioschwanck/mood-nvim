local wk = require("which-key")

local function Split(s, delimiter)
  result = {};

  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

local function count_in_list(list, element)
  local count = 0

  for i=1,#list,1 do
    if list[i] == element then
      count = count + 1
    end
  end

  return count
end

local function toggle_harpoon()
  local harpoon = require("harpoon")
  local index = 1
  local harpoons = {
    name = "Harpoon",
    s = { ':lua require("harpoon.mark").add_file()<CR>', "Add File to Harpoon" },
    f = { ':lua require("harpoon.ui").toggle_quick_menu()<CR>', "Open Quick Menu" },
    c = { ':lua require("harpoon.mark").clear_all()<CR>', "Clear Harpoon" }
  }

  local marks = harpoon.get_mark_config().marks

  local filenames = {}

  for i=1,#marks,1 do
    local file_splitted = Split(marks[i].filename, "/")

    filenames[i] = file_splitted[#file_splitted]
  end

  for i=1,#marks,1 do
    local file_to_show

    if count_in_list(filenames, filenames[index]) > 1 then
      local filename_full = Split(marks[i].filename, "/")

      table.remove(filename_full, #filename_full)

      local parsed_filename = ""

      for j=1,#filename_full,1 do
        parsed_filename = parsed_filename .. "/" .. filename_full[j]
      end

      file_to_show = filenames[index] .. ' at ' .. parsed_filename
    else
      file_to_show = filenames[index]
    end

    harpoons[tostring(index)] = { ":lua require'harpoon.ui'.nav_file(" .. index .. ")<CR>", file_to_show }
    index = index + 1
  end

  local ignored = {}

  for i=1,20,1 do
    ignored[tostring(i)] = "which_key_ignore"
  end

  wk.register({
    y = ignored,
  }, { prefix = "<leader>", silent = false })

  wk.register({
    y = harpoons,
  }, { prefix = "<leader>", silent = false })

  vim.cmd('WhichKey <leader>y')
end

return toggle_harpoon

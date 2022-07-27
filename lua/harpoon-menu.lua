local wk = require("which-key")

local common_words = {
  "create",
  "Create",
  "update",
  "Update",
  "Delete",
  "delete",
  "Destroy",
  "destroy",
  "index",
  "Index",
  "find",
  "Find",
  "read",
  "Read",
  "init",
  "Init"
}

local function Split(s, delimiter)
  local result = {};

  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

local function SplitWithDot(s)
  local lines = {}
  for line in s:gsub("%f[.]%.%f[^.]", "\0"):gmatch"%Z+" do
    table.insert(lines, line)
  end

  return lines
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
    s = { ':lua require("harpoon.mark").add_file()<CR>', "+Add File to Harpoon" },
    f = { ':lua require("harpoon.ui").toggle_quick_menu()<CR>', "+Edit Harpoon File" },
    c = { ':lua require("harpoon.mark").clear_all()<CR>', "+Clear Harpoon" }
  }

  local marks = harpoon.get_mark_config().marks

  local filenames = {}

  for i=1,#marks,1 do
    local file_splitted = Split(marks[i].filename, "/")

    filenames[i] = file_splitted[#file_splitted]
  end

  for i=1,#marks,1 do
    local file_to_show
    local extension

    if count_in_list(filenames, filenames[index]) > 1 then
      local filename_full = Split(marks[i].filename, "/")

      table.remove(filename_full, #filename_full)

      local parsed_filename = ""

      extension = SplitWithDot(filenames[index])
      extension = extension[#extension]

      local parsed_filename = ''

      if #filename_full > 1 then
        parsed_filename = parsed_filename .. "/" .. filename_full[#filename_full]
      end

      file_to_show = parsed_filename .. '/' .. filenames[index]
    else
      extension = SplitWithDot(filenames[index])
      extension = extension[#extension]

      local show_path = false

      for _index, value in pairs(common_words) do
        if string.find(filenames[index], value, 1, false) then
          show_path = true
        end
      end

      if show_path then
        local filename_full = Split(marks[i].filename, "/")

        table.remove(filename_full, #filename_full)

        local parsed_filename = ""

        if #filename_full > 1 then
          parsed_filename = parsed_filename .. "/" .. filename_full[#filename_full]
        end

        if parsed_filename ~= '' then
          local splitted = Split(parsed_filename, '/')

          file_to_show = splitted[#splitted] .. '/' .. filenames[index]
        else
          file_to_show = filenames[index]
        end
      else
        file_to_show = filenames[index]
      end
    end

    local icon = ''

    if file_to_show and extension then
      icon = require'nvim-web-devicons'.get_icon(file_to_show, extension, { default = true })
    end

    harpoons[tostring(index)] = { ":lua require'harpoon.ui'.nav_file(" .. index .. ")<CR>", icon .. ' ' .. file_to_show }
    index = index + 1
  end

  local ignored = {}
for i=1,20,1 do
    ignored[tostring(i)] = "which_key_ignore"
  end

  wk.register({
    ["&"] = ignored,
  }, { prefix = "<leader>", silent = false })

  wk.register({
    ["&"] = harpoons,
  }, { prefix = "<leader>", silent = false })

  vim.cmd('WhichKey <leader>&')
end

return toggle_harpoon

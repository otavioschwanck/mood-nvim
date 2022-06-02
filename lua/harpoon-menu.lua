local wk = require("which-key")

local function toggle_harpoon()
  local harpoon = require("harpoon")
  local index = 1
  local harpoons = {
    name = "Harpoon",
    s = { ':lua require("harpoon.mark").add_file()<CR>', "Add File to Harpoon" },
    f = { ':lua require("harpoon.ui").toggle_quick_menu()<CR>', "Open Quick Menu" },
    c = { ':lua require("harpoon.mark").clear_all()<CR>', "Clear Harpoon" }
  }
  local config = harpoon.get_mark_config().marks[index]

  while config do
    harpoons[tostring(index)] = { ":lua require'harpoon.ui'.nav_file(" .. index .. ")<CR>", config.filename }
    index = index + 1
    config = harpoon.get_mark_config().marks[index]
  end

  local ig_index = 1
  local ignored = {}

  while ig_index < 20 do -- Please, dont do more than 20 harpoon in single project
    ignored[tostring(ig_index)] = "which_key_ignore"
    ig_index = ig_index + 1
  end

  print(vim.inspect(ignored))

  wk.register({
    y = ignored,
  }, { prefix = "<leader>", silent = false })

  wk.register({
    y = harpoons,
  }, { prefix = "<leader>", silent = false })

  vim.cmd('WhichKey <leader>y')
end

return toggle_harpoon

local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local alternate = require "telescope-alternate.finders"

function M.call()
  local results = {
    {
      path = "~/.config/nvim/lua/user/config.lua",
      display = "User Configuration | Configure your neovim plugins, themes, etc.",
      order = "1"
    },
    {
      path = "~/.config/nvim/lua/user/keybindings.lua",
      display = "Keybindings        | Configure your personal keybindings.",
      order = "2"
    },
    {
      path = "~/.config/nvim/lua/user/lsp.lua",
      display = "LSP                | Configure the LSP (Language server protocol)",
      order = "3"
    },
    {
      path = "~/.config/nvim/lua/user/plugins.lua",
      display = "Plugins            | Add more plugins to your neovim.",
      order = "4"
    },
  }

  pickers.new({}, {
    prompt_title = "User Files",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        return { value = entry.path, display = entry.display, ordinal = entry.order }
      end
    },
    sorter = conf.generic_sorter({}),
    previewer = conf.file_previewer({}),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry().value

        vim.cmd("e " .. selection)
      end)
      return true
    end,
  }):find()
end

return M

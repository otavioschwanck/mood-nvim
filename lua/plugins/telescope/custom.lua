local Path = require "plenary.path"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local os_sep = Path.path.sep
local pickers = require "telescope.pickers"
local builtin = require "telescope.builtin"
local scan = require "plenary.scandir"

local custom_pickers = {}

custom_pickers.ripgrep = function()

vim.ui.input({ prompt = 'Enter something to query: ' }, function(input)

        builtin.grep_string({
                find_command = {
                        "rg",
                        "-g", "!.git",
                        "-g", "!node_modules",
                        "-g", "!package-lock.json",
                        "-g", "!yarn.lock",
                        "--hidden",
                        "--no-ignore-global",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                },
                search = input,
        })
end)
end

custom_pickers.live_grep_in_folder = function(opts)
  opts = opts or {}
  local data = {}
  scan.scan_dir(vim.loop.cwd(), {
    hidden = opts.hidden,
    only_dirs = true,
    respect_gitignore = opts.respect_gitignore,
    on_insert = function(entry)
      table.insert(data, entry .. os_sep)
    end,
  })
  table.insert(data, 1, "." .. os_sep)

  pickers.new(opts, {
    prompt_title = "Folders for Live Grep",
    finder = finders.new_table { results = data, entry_maker = make_entry.gen_from_file(opts) },
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      action_set.select:replace(function()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        local dirs = {}
        local selections = current_picker:get_multi_selection()
        if vim.tbl_isempty(selections) then
          table.insert(dirs, action_state.get_selected_entry().value)
        else
          for _, selection in ipairs(selections) do
            table.insert(dirs, selection.value)
          end
        end
        actions._close(prompt_bufnr, current_picker.initial_mode == "insert")
        require("telescope.builtin").live_grep { search_dirs = dirs }
      end)
      return true
    end,
  }):find()
end

local filter = vim.tbl_filter

return custom_pickers

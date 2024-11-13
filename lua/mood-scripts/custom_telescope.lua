local Path = require("plenary.path")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local os_sep = Path.path.sep
local pickers = require("telescope.pickers")
local builtin = require("telescope.builtin")
local scan = require("plenary.scandir")
local telescopeMakeEntryModule = require("telescope.make_entry")

local custom_pickers = {}

-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

custom_pickers.filename_first = function(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)

  if parent == "." then return tail end

  return string.format("%s\t\t%s", tail, parent)
end

custom_pickers.project_files = function()
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")

    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require("telescope.builtin").git_files({})
  else
    require("telescope.builtin").find_files({})
  end
end

custom_pickers.ripgrep = function()
  vim.ui.input({ prompt = "Enter something to query: " }, function(input)
    builtin.grep_string({
      find_command = {
        "rg",
        "-g",
        "!.git",
        "-g",
        "!node_modules",
        "-g",
        "!package-lock.json",
        "-g",
        "!yarn.lock",
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

  pickers
      .new(opts, {
        prompt_title = "Folders for Live Grep",
        finder = finders.new_table({ results = data, entry_maker = make_entry.gen_from_file(opts) }),
        previewer = conf.file_previewer(opts),
        sorter = conf.file_sorter(opts),
        additional_args = { "-j1" },
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

            local cwd = vim.fn.getcwd() .. "/"

            for i, item in ipairs(dirs) do
              dirs[i] = string.gsub(item, cwd, "")
            end

            require("telescope").extensions.egrepify.egrepify({
              search_dirs = dirs,
              layout_strategy = require("mood-scripts.layout_strategy").grep_layout(),
            })
          end)
          return true
        end,
      })
      :find()
end

local filter = vim.tbl_filter

return custom_pickers

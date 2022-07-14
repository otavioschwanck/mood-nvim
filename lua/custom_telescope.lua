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

custom_pickers.terminals = function(opts)
  opts = opts or {}

  local bufnrs = filter(function(b)
    if not (vim.fn.getbufvar(b, '&buftype', 'ERROR') == 'terminal') then
            return false
    end

    if string.find(vim.fn.bufname(b), ':lazygit') then
            return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  if not next(bufnrs) then
    require('notify')("No terminals found.", 'warn', { title='Terminal Management'  })
    return
  end

  table.sort(bufnrs, function(a, b)
    return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
  end)

  local buffers = {}
  local default_selection_idx = 1
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == vim.fn.bufnr "" and "%" or (bufnr == vim.fn.bufnr "#" and "#" or " ")

    local element = {
      bufnr = bufnr,
      flag = flag,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    table.insert(buffers, element)
  end

  local max_bufnr = math.max(unpack(bufnrs))
  opts.bufnr_width = #tostring(max_bufnr)

  pickers.new(opts, {
    prompt_title = "Terminals",
    finder = finders.new_table {
      results = buffers,
      entry_maker = opts.entry_maker or make_entry.gen_from_buffer(opts),
    },
    previewer = conf.grep_previewer(opts),
    attach_mappings = function(_, map)
      map('i', '<CR>',
        function()
          local result = action_state.get_selected_entry().value

          vim.cmd("b! " .. result .. " | norm! GA")
          vim.b.common_open = 1
        end
      )

      map('i', '<C-v>',
        function(prompt_bufnr)
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local result = action_state.get_selected_entry().value

          actions._close(prompt_bufnr, current_picker.initial_mode == "insert")

          vim.cmd("vert sb " .. result .. " | norm! GA")
          vim.b.common_open = 1
        end
      )

      map('i', '<C-s>',
        function(prompt_bufnr)
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local result = action_state.get_selected_entry().value

          actions._close(prompt_bufnr, current_picker.initial_mode == "insert")

          vim.cmd("b! " .. result .. " | norm! GA")
          vim.b.common_open = 1
        end
      )

      return true
    end,
    sorter = conf.generic_sorter(opts),
    default_selection_index = default_selection_idx
  }):find()
end

return custom_pickers



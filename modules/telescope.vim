let g:folder_to_ignore = [".*.git/.*", "node_modules/.*"]

lua <<EOF
local _, actions = pcall(require, "telescope.actions")

local fb_actions = require "telescope".extensions.file_browser.actions

local vertical_search = { path_display = { "smart" }, layout_strategy = "vertical", layout_config = { preview_cutoff = 10, height = 0.92 } }

require('telescope').setup{
  defaults = {
    prompt_prefix = " ",
    file_ignore_patterns = vim.g.folder_to_ignore,
    layout_config = { width = 0.95 },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  },
  pickers = {
    find_files = {
      hidden = true, path_display = { "smart" }
    },
    buffers = { path_display = { "smart" } },
    live_grep = vertical_search,
    grep_string = vertical_search
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown { }
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    file_browser = {
      hidden = true,
      mappings = {
        ["i"] = {
          ["<C-o>"] = fb_actions.remove,
          ["<C-p>"] = fb_actions.copy,
          ["<C-e>"] = fb_actions.move,
          ["<C-space>"] = fb_actions.create_from_prompt,
          ["<C-r>"] = fb_actions.rename,
          ["<C-c>"] = fb_actions.goto_parent_dir,
          ["<C-w>"] = nil,
          ["<C-g>"] = fb_actions.goto_cwd,
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          ["<C-o>"] = fb_actions.remove,
          ["<C-p>"] = fb_actions.copy,
          ["<C-e>"] = fb_actions.move,
          ["<C-space>"] = fb_actions.create_from_prompt,
          ["<C-r>"] = fb_actions.rename,
          ["<C-c>"] = fb_actions.goto_parent_dir
        },
      },
    },
  },
}

local utils = require('telescope.utils')
local set_var = vim.api.nvim_set_var

local git_root, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, vim.loop.cwd())

local function get_dashboard_git_status()
  local git_cmd = {'git', 'status', '-s', '--', '.'}
  local output = utils.get_os_command_output(git_cmd)
  local message = '       Git status:'

  if unpack(output) == '' then
    message = 'Welcome!'
  end
  set_var('dashboard_custom_footer', {message, '', unpack(output)})
end

if ret ~= 0 then
  local is_worktree = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" }, vim.loop.cwd())
  if is_worktree[1] == "true" then
    get_dashboard_git_status()
  else
    set_var('dashboard_custom_footer', {'Welcome!'})
  end
else
    get_dashboard_git_status()
end

require("telescope").load_extension("ui-select")
require("telescope").load_extension "file_browser"
require('telescope').load_extension('fzf')
require('telescope').load_extension('neoclip')

require('neoclip').setup({
  enable_persistent_history = true,
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-n>',
        paste_behind = '<C-p>',
        replay = '<c-q>',  -- replay a macro
        delete = '<c-d>',  -- delete an entry
        custom = {},
        },
      n = {
        select = '<cr>',
        paste = 'p',
        paste_behind = 'P',
        replay = 'q',
        delete = 'd',
        custom = {},
        },
      },
    }
  })
EOF



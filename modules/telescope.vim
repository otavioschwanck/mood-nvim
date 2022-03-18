lua <<EOF
local _, actions = pcall(require, "telescope.actions")

local fb_actions = require "telescope".extensions.file_browser.actions

require('telescope').setup{
  defaults = {
    file_ignore_patterns = { ".*.git/.*" },
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
      hidden = true
    },
    buffers = { path_display = { "tail" } }
  } ,
  extensions = {
    file_browser = {
      hidden = true,
      mappings = {
        ["i"] = {
          ["<C-a>"] = fb_actions.create,
          ["<C-v>"] = fb_actions.copy,
          ["<C-e>"] = fb_actions.move,
          ["<C-space>"] = fb_actions.remove,
          ["<C-r>"] = fb_actions.rename,
          ["<C-c>"] = fb_actions.goto_parent_dir,
        },
        ["n"] = {
          ["<C-a>"] = fb_actions.create,
          ["<C-v>"] = fb_actions.copy,
          ["<C-e>"] = fb_actions.move,
          ["<C-space>"] = fb_actions.remove,
          ["<C-r>"] = fb_actions.rename,
          ["<C-c>"] = fb_actions.goto_parent_dir,
        },
      },
    },
  },
}

require"telescope".load_extension("tmux")
require('telescope').load_extension('coc')
require('telescope').load_extension('projects')
require("telescope").load_extension "file_browser"
EOF

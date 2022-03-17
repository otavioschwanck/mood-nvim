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
          ["<C-a>"] = fb_actions.create
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}

local actions = require('telescope.actions')require('telescope').setup{
  pickers = {
    buffers = {
      sort_lastused = true,
      ignore_current_buffer = true
    }
  }
}

require"telescope".load_extension("frecency")
require"telescope".load_extension("tmux")
require('telescope').load_extension('coc')
require('telescope').load_extension('projects')
EOF

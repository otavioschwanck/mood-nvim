local M = {}

local telescope = require("telescope")

function M.setup()
  local _, actions = pcall(require, "telescope.actions")

  local fb_actions = require "telescope".extensions.file_browser.actions

  local vertical_search = { path_display = { "smart" }, layout_strategy = "vertical", layout_config = { preview_cutoff = 10, height = 0.92 } }

  telescope.setup{
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
      buffers = { path_display = require('utils.buffer_path_display'), layout_config = { preview_cutoff = 10, width = 0.92 } },
      live_grep = vertical_search,
      grep_string = vertical_search,
      diagnostics = vertical_search,
      coc = {
        diagnostics = vertical_search,
      },
      current_buffer_fuzzy_find = vertical_search
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown { }
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

  telescope.load_extension("ui-select")
  telescope.load_extension "file_browser"
  telescope.load_extension('neoclip')
  telescope.load_extension('ultisnips')
  telescope.load_extension('dap')
  telescope.load_extension('coc')

  require('neoclip').setup({
    enable_persistent_history = true,
    keys = {
      telescope = {
        i = {
          paste = '<cr>',
          paste_behind = '<C-p>',
          replay = '<c-q>',
          delete = '<c-d>',
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
end

M.setup()

return M

local M = {}

local telescope = require("telescope")

function M.setup()
  local _, actions = pcall(require, "telescope.actions")

  local fb_actions = require("telescope").extensions.file_browser.actions
  local mapping = require("yanky.telescope.mapping")

  require("telescope").setup({
    defaults = {
      layout_strategy = "flex",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          height = 0.9,
        },
        vertical = {
          prompt_position = "top",
        },
      },
      sorting_strategy = "ascending",
      prompt_prefix = " ",
      file_ignore_patterns = vim.g.folder_to_ignore,
      mappings = {
        i = {
          ["<C-e>"] = function(picker)
            actions.send_selected_to_qflist(picker)
            vim.cmd("copen")
          end,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        path_display = require("mood-scripts.custom_telescope").filename_first,
      },
      git_files = {
        show_untracked = true,
        path_display = require("mood-scripts.custom_telescope").filename_first,
      },
    },
    extensions = {
      egrepify = {
        filename_hl = "@attribute",
        lnum_hl = "LineNr",
      },
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
      file_browser = {
        hidden = true,
        prompt_path = true,
        hide_parent_dir = true,
        grouped = true,
        mappings = {
          ["i"] = {
            ["<C-d>"] = fb_actions.remove,
            ["<C-v>"] = fb_actions.copy,
            ["<C-x>"] = fb_actions.move,
            ["<C-space>"] = fb_actions.create_from_prompt,
            ["<C-r>"] = fb_actions.rename,
            ["<C-b>"] = fb_actions.goto_cwd,
            ["<C-w>"] = function()
              vim.cmd("normal vbd")
            end,
          },
          ["n"] = {
            ["<C-d>"] = fb_actions.remove,
            ["<C-v>"] = fb_actions.copy,
            ["<C-x>"] = fb_actions.move,
            ["<C-space>"] = fb_actions.create_from_prompt,
            ["<C-r>"] = fb_actions.rename,
            ["<C-b>"] = fb_actions.goto_cwd,
          },
        },
      },
    },
  })

  require("telescope").load_extension("yank_history")
  require("telescope").load_extension("ui-select")
  require("telescope").load_extension("file_browser")
  require("telescope").load_extension("telescope-alternate")
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("tmux-awesome-manager")
  require("telescope").load_extension("egrepify")
end

return M

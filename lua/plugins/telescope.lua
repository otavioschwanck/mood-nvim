return {
  'otavioschwanck/telescope-alternate.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-lua/plenary.nvim',
      {
        'gbprod/yanky.nvim',
        config = function()
          local mapping = require("yanky.telescope.mapping")
          local utils = require("yanky.utils")

          require("yanky").setup({
            ring = {
              history_length = 50,
              storage = "shada",
              sync_with_numbered_registers = true,
            },
            preserve_cursor_position = {
              enabled = true,
            },
            picker = {
              telescope = {
                mappings = {
                  default = mapping.put("p"),
                  i = {
                    ["<C-r>"] = mapping.put("p"),
                    ["<c-k>"] = mapping.put("P"),
                    ["<c-x>"] = mapping.delete(),
                    ["<c-r>"] = mapping.set_register(utils.get_default_register()),
                  },
                  n = {
                    p = mapping.put("p"),
                    P = mapping.put("P"),
                    d = mapping.delete(),
                    r = mapping.set_register(utils.get_default_register())
                  },
                }
              }
            }
          })

          vim.api.nvim_set_keymap("n", "p", "<Plug>(YankyPutAfter)", {})
          vim.api.nvim_set_keymap("n", "P", "<Plug>(YankyPutBefore)", {})
          vim.api.nvim_set_keymap("x", "p", "<Plug>(YankyPutAfter)", {})
          vim.api.nvim_set_keymap("x", "P", "<Plug>(YankyPutBefore)", {})

          vim.api.nvim_set_keymap("n", "y", "<Plug>(YankyYank)", {})
          vim.api.nvim_set_keymap("x", "y", "<Plug>(YankyYank)", {})

          vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleForward)", {})
          vim.api.nvim_set_keymap("n", "g<c-p>", "<Plug>(YankyCycleBackward)", {})
        end
      },
      { 'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    },
    config = function()
      local _, actions = pcall(require, "telescope.actions")

      local fb_actions = require "telescope".extensions.file_browser.actions

      local winwidth = vim.fn.winwidth(0)

      local vertical_search

      if winwidth < 250 then
        vertical_search = {
          layout_strategy = "vertical",
          layout_config = { preview_cutoff = 10, height = 0.90, width = 0.95 },
        }
      else
        vertical_search = {
          layout_strategy = "horizontal",
        }
      end

      ternary = function(cond, T, F)
        if cond then return T else return F end
      end

      require('telescope').setup {
        defaults = {
          prompt_prefix = " ",
          file_ignore_patterns = vim.g.folder_to_ignore,
          borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          layout_config = ternary(winwidth < 250, { preview_cutoff = 10, height = 0.90, width = 0.95 }, nil),
          mappings = {
            i = {
              ["<C-e>"] = function(picker)
                actions.send_selected_to_qflist(picker)
                vim.cmd("copen")
              end,
            },
          }
        },
        pickers = {
          find_files = {
            hidden = true
          },
          buffers = { path_display = require('utils.buffer_path_display'),
            layout_config = { preview_cutoff = 10, width = 0.92 } },
          live_grep = vertical_search,
          grep_string = vertical_search,
          diagnostics = vertical_search,
          current_buffer_fuzzy_find = vertical_search
        },
        extensions = {
          fzf = {
            fuzzy = true,
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          },
          file_browser = {
            hidden = true,
            mappings = {
              ["i"] = {
                ["<C-o>"] = fb_actions.remove,
                ["<C-y>"] = fb_actions.copy,
                ["<C-e>"] = fb_actions.move,
                ["<C-space>"] = fb_actions.create_from_prompt,
                ["<C-r>"] = fb_actions.rename,
                ["<C-c>"] = fb_actions.goto_parent_dir,
                ["<C-g>"] = fb_actions.goto_cwd,
                ["<C-w>"] = function() vim.cmd('normal vbd') end,
              },
              ["n"] = {
                ["<C-o>"] = fb_actions.remove,
                ["<C-y>"] = fb_actions.copy,
                ["<C-e>"] = fb_actions.move,
                ["<C-space>"] = fb_actions.create_from_prompt,
                ["<C-r>"] = fb_actions.rename,
                ["<C-c>"] = fb_actions.goto_parent_dir
              },
            },
          },
        },
      }

      require("telescope").load_extension("yank_history")
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension "file_browser"
      require('telescope').load_extension('telescope-alternate')
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('tmux-awesome-manager')
    end
  }
}

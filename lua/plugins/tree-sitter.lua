local M = {}

function M.setup()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",

    textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer"
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      rainbow = { enabled = true, extended_mode = true, max_file_lines = 1500 },
      select = {
        enable = true,

        lookahead = true,

        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
    },

    endwise = {
      enable = true,
    },


    -- List of parsers to ignore installing
    ignore_install = { "phpdoc" },

    autotag = {
      enable = true,
    },
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    indent = { enable = true, disable = { "ruby", "python" } },

    highlight = {
      enable = true,
    },
  }
end

return M

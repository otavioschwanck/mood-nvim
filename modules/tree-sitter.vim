lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]c"] = "@class.outer",
        ["]]"] = "@function.outer",
      },
      goto_next_end = {
        ["]C"] = "@class.outer",
        ["]["] = "@function.outer",
      },
      goto_previous_start = {
        ["[c"] = "@class.outer",
        ["[["] = "@function.outer",
      },
      goto_previous_end = {
        ["[C"] = "@class.outer",
        ["[]"] = "@function.outer",
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

  autotag = {
    enable = true,
  },
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    enable = true,
  },
}
EOF

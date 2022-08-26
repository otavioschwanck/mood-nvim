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

  require'treesitter-context'.setup{
    enable = true,
    max_lines = 0,
    trim_scope = 'outer',
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        'class',
        'function',
        'method',
        'for', -- These won't appear in the context
        'while',
        'if',
        'switch',
        'case',
        'element',
        'call'
      },
    },
    exact_patterns = { },

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
  }
end

return M

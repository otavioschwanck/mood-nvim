  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vs-snippets" } })

  local lsp = require('lsp-zero')

  lsp.preset('recommended')

  local cmp = require('cmp')
  local luasnip = require("luasnip")

  lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'solargraph',
    'jsonls',
    'solidity'
  })

  lsp.configure('solidity', {
    settings = {
      solidity = { includePath = '', remapping = { ["@OpenZeppelin/"] = 'dependencies/OpenZeppelin/openzeppelin-contracts@4.6.0/' } }
    }
  })

  -- the reason to configure solargraph here and use diagnosticsls, is because if handles better the rubocop, specially for big projects.
  -- Just comment lsp.configure(solargraph) and lsp.configure(diagnosticsls) if you want the default stuff.
  lsp.configure('solargraph', {
    flags = {
      debounce_text_changes = 50,
    },
    settings = {
      solargraph = {
        diagnostics = false,
        formatting = true,
        useBundler = true
      }
    }
  })

  lsp.configure('diagnosticls', {
    filetypes = { "ruby" },
    single_file_support = false,
    init_options = {
      linters = {
        rubocop = {
          command = "bundle",
          sourceName = "rubocop",
          debounce = 100,
          args = { "exec",
            "rubocop",
            "--format",
            "json",
            "--force-exclusion",
            "--stdin",
            "%filepath"
          },
          parseJson = {
            errorsRoot = "files[0].offenses",
            line = "location.start_line",
            endLine = "location.last_line",
            column = "location.start_column",
            endColumn = "location.end_column",
            message = "[${cop_name}] ${message}",
            security = "severity"
          },
          securities = {
            fatal = "error",
            error = "error",
            warning = "warning",
            convention = "info",
            refactor = "info",
            info = "info"
          }
        },
        shellcheck = {
          command = "shellcheck",
          debounce = 100,
          args = { "--format=gcc", "-"},
          offsetLine = 0,
          offsetColumn = 0,
          sourceName = "shellcheck",
          formatLines = 1,
          formatPattern = {
            "^[^:]+:(\\d+):(\\d+):\\s+([^:]+):\\s+(.*)$",
            {
              line = 1,
              column = 2,
              message = 4,
              security = 3
            }
          },
          securities = {
            error = "error",
            warning = "warning",
            note = "info"
          }
        },
        languagetool = {
          command = "languagetool",
          debounce = 200,
          args = {"-"},
          offsetLine = 0,
          offsetColumn = 0,
          sourceName = "languagetool",
          formatLines = 2,
          formatPattern = {
            "^\\d+?\\.\\)\\s+Line\\s+(\\d+),\\s+column\\s+(\\d+),\\s+([^\\n]+)\nMessage:\\s+(.*)$",
            {
              line = 1,
              column = 2,
              message = { 4, 3 }
            }
          }
        }
      },
      filetypes = {
        sh = "shellcheck",
        email = "languagetool",
        ruby = "rubocop"
      }
    }
  })

  lsp.nvim_workspace()

  local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-d>'] = cmp.mapping(function (fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end),
  })

  local sources = { { name = "path" },
    { keyword_length = 2, name = "nvim_lsp" },
    { name = "buffer", option = { get_bufnrs = require('utils.valid_listed_buffers') } },
    { name = "luasnip", keyword_length = 2 },
    { name = "calc" }
  }

  lsp.setup_nvim_cmp({
    sources = sources,
    mapping = cmp_mappings
  })

  lsp.setup()

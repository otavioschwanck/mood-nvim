--------------------------
-- NVIM_LSPCONFIG (LSP) --
--------------------------
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', ':Telescope lsp_definitions<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', ':Telescope lsp_implementation<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', ':Telescope lsp_type_definitions<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', ':Telescope lsp_references<CR>', opts)
end

-------------------------
-- NVIM CMP (SNIPPETS) --
-------------------------

local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local cmp = require("cmp")

local lspkind = require('lspkind')

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  -- Uncomment this to automatically select first occurrence
  -- completion = {
  --   completeopt = 'menu,menuone,noinsert'
  -- },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "ultisnips" },
    { name = "buffer", option = { get_bufnrs = function()
      return vim.api.nvim_list_bufs()
    end
    }},
    { name = "path" },
    { name = "calc" }
  }),
  mapping = {
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { "select_next_item" }(fallback)
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.compose { "select_prev_item" }(fallback)
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-g>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ["<C-j>"] = cmp.mapping(
      function()
        cmp_ultisnips_mappings.compose { "jump_forwards", "expand" }()
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ["<C-k>"] = cmp.mapping(
      function(fallback)
        cmp_ultisnips_mappings.jump_backwards(fallback)
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
  },
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

local servers = { 'pyright', 'tsserver', 'jsonls', 'html', 'yamlls', 'stylelint_lsp', 'cssls', 'solidity_ls', 'sumneko_lua' }

cfg = {
  bind = true,
  handler_opts = {
    border = "rounded"
  }
}

require "lsp_signature".setup()

local lspconfig = require('lspconfig')

lspconfig.solargraph.setup {
  on_attach = on_attach,
  settings = {
    solargraph = {
      diagnostics = false
    }
  }
}

lspconfig.diagnosticls.setup {
  filetypes = { "ruby" },
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
    formatters = {
      dartfmt = {
        command = "dartfmt",
        args = { "--fix" }
      },
      rubocop = {
        command = "bundle",
        args = { "exec",
          "rubocop",
          "-a",
          "%filepath",
          ">",
          "tmp/rubocop"
        }
      }
    },
    filetypes = {
      sh = "shellcheck",
      email = "languagetool",
      ruby = "rubocop"
    },
    formatFiletypes = {
      dart = "dartfmt",
      ruby = "rubocop"
    }
  }

}

for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,

    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 50,
    }
  }
end

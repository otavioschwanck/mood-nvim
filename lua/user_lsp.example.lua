--------------------------
-- NVIM_LSPCONFIG (KEYMAPS)
--------------------------
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', bufopts)
end

-------------------------
-- NVIM CMP (SNIPPETS) --
-------------------------

local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local cmp = require("cmp")

local lspkind = require('lspkind')

local mappings = {
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
  ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-g>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
  ['<CR>'] = cmp.mapping.confirm({ select = false }),
  ["<C-j>"] = cmp.mapping(
    function()
      cmp_ultisnips_mappings.compose { "jump_forwards", "expand" }(function ()

      end)
    end,
    { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
  ),
  ["<C-k>"] = cmp.mapping(
    function(fallback)
      cmp_ultisnips_mappings.jump_backwards(fallback)
    end,
    { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
  ),
}

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  },
  -- completion = {
  --   completeopt = 'menu,menuone,noinsert'
  -- },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "ultisnips" },
    { name = "buffer", option = { get_bufnrs = function()
      return require('valid_listed_buffers')()
    end
    }},
    { name = "path" },
    { name = "calc" }
  }),
  mapping = mappings,
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

-- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

local servers = { 'pyright', 'tsserver', 'jsonls', 'html', 'yamlls', 'cssls', 'solidity_ls', 'sumneko_lua' }

require "lsp_signature".setup()

local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    solargraph = {
      diagnostics = false
    }
  }
}

lspconfig.diagnosticls.setup {
  filetypes = { "ruby" },
  capabilities = capabilities,
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
    capabilities = capabilities,

    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 50,
    }
  }
end

local empty_function = function(fallback) fallback() end

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline({ ['<C-p>'] = empty_function, ['<C-n>'] = empty_function}),
    sources = {
    { name = "buffer", option = { get_bufnrs = function()
      return require('valid_listed_buffers')()
    end } }
    }
})


cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({ ['<C-p>'] = empty_function, ['<C-n>'] = empty_function}),
    sources = cmp.config.sources({
        { name = 'path' }
        },
    {
        { name = 'cmdline' },
    { name = "buffer", option = { get_bufnrs = function()
      return require('valid_listed_buffers')()
    end } }
    })
})

--------------------------
-- NVIM_LSPCONFIG (KEYMAPS)
--------------------------

-- What LSP servers do you want?
local servers = { 'jedi_language_server', 'tsserver', 'jsonls', 'yamlls', 'cssls', 'solidity_ls', 'sumneko_lua', 'eslint' }

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', ':Telescope lsp_definitions<CR>', bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', bufopts)
end

vim.diagnostic.config {
   virtual_text = true, -- Change to false if you dislike the virtual text (diagnostic at right)
   signs = true,
   underline = false,
   update_in_insert = false,
}

-- -- Show line diagnostics automatically in hover window (Uncomment if you set virtual_text to false)

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
  ['<C-e>'] = cmp.mapping.confirm({ select = false }),
  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-g>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
  ['<CR>'] = cmp.mapping.confirm({ select = false }),
  ["<C-j>"] = cmp.mapping(
    function(fallback)
      cmp_ultisnips_mappings.compose { "expand", "jump_forwards" }(fallback)
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
  window = {
    completion = {
      scrollbar = '║',
      winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
    },
    documentation = {
      scrollbar = '║',
    },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
    })
  },
  -- completion = { completeopt = 'menu,menuone,noinsert' }, -- uncomment this to highlight first item by default
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "ultisnips" },
    { name = "buffer", option = { get_bufnrs = function()
      return require('utils.valid_listed_buffers')()
    end
    }},
    { name = "path" },
    { name = 'tmux', option = { all_panes = true } },
    { name = "calc" }
  }),
  mapping = mappings,
})

-- Add automatically () at methods
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

require "lsp_signature".setup()

local lspconfig = require('lspconfig')

lspconfig.solidity.setup({
  on_attach = on_attach,
  settings = {
    solidity = { includePath = '', remapping = { ["@OpenZeppelin/"] = 'OpenZeppelin/openzeppelin-contracts@4.6.0/' } }
  },
})

require'lspconfig'.html.setup {
  filetypes = { "eruby", "html" },
  on_attach = on_attach,
  init_options = {
    configurationSection = { "html", "css", "javascript", "eruby" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  }
}

lspconfig.solargraph.setup {
  on_attach = on_attach,
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
}

-- -- if your rubocop doesn't work with Solargraph, just uncomment this and set diagnostics to false above (on solargraph)
lspconfig.diagnosticls.setup {
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

local empty_function = function(fallback) fallback() end

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline({ ['<C-p>'] = empty_function, ['<C-n>'] = empty_function}),
    sources = {
    { name = "buffer" }
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
      return require('utils.valid_listed_buffers')()
    end } }
    })
})

local function lspSymbol(name, icon)
   local hl = "DiagnosticSign" .. name
   vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        severity_sort = true
    }
)

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end

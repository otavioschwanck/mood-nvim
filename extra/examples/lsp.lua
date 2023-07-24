-- LSP --------------------------------------------
-- Your Language server protocol stuff
---------------------------------------------------
-- Configure autocomplete keybindings, servers, etc
-- Line 26: LSPs to install. See the list at: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- Line 37: On attach (configure keybindings for LSP)
-- Line 105: Mappings for autocomplete
-- Line 183: Linter and Formatter (prettier, rubocop, etc)

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vs-snippets" } })


-- Plugins that we will use to setup LSP
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local cmp = require('cmp')
local luasnip = require("luasnip")

-- Setup Mason
require('mason').setup()

-- Configure your servers.
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'lua_ls',
    'jsonls',
    'solidity',
    'yamlls',
    'jsonls',
    'solargraph'
  }
})

-- when LSP os connceted, this function is called.
local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }

  local bind = vim.keymap.set

  bind('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  bind('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  bind('n', 'gI', '<cmd>Telescope lsp_implementations<cr>', opts)
  bind('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', opts)
  bind('n', 'K', vim.lsp.buf.hover, opts)
end

-- Add our on_attach for mason installed LSP.
require('mason-lspconfig').setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = lsp_capabilities,
    })
  end,
})

-- just uncomment this if mason ins not handling the on_attach

-- local get_servers = require('mason-lspconfig').get_installed_servers

-- for _, server_name in ipairs(get_servers()) do
--   lspconfig[server_name].setup({
--     on_attach = on_attach,
--     capabilities = lsp_capabilities,
--   })
-- end

vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" } -- Dont select first item

lspconfig['solidity'].setup({                                       -- setup solidity (remove if you don't use)
  on_attach = on_attach,
  settings = {
    solidity = {
      includePath = '',
      remapping = { ["@OpenZeppelin/"] = 'dependencies/OpenZeppelin/openzeppelin-contracts@4.6.0/' }
    }
  }
})

lspconfig['solargraph'].setup( -- setup solargraph (remove if you don't use)
  {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 50,
    },
    settings = {
      solargraph = {
        formatting = true, -- solargraph format is just faster
        useBundler = true,
        -- change to true if you want to use here instead of guard (guard is faster for it, look at the end of file)
        diagnostics = false,
      }
    }
  })

local sources = { { name = "path" }, -- cmp sources
  { keyword_length = 2, name = "nvim_lsp" },
  { name = "buffer",    option = { get_bufnrs = require('utils.valid_listed_buffers') } },
  { name = "luasnip",   keyword_length = 2 },
  { name = "calc" }
}

local autocomplete_mappings = { -- autocomplete mappings
  ['<Tab>'] = cmp.mapping.select_next_item({ select = true }),
  ['<S-Tab>'] = cmp.mapping.select_prev_item({ select = true }),
  ['<CR>'] = cmp.mapping.confirm(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<C-n>'] = cmp.mapping(function(fallback)
    if luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump(1)
    end
  end, { 'i', 's' }),
  ['<C-p>'] = cmp.mapping(function(fallback)
    if luasnip.locally_jumpable() then
      luasnip.jump(-1)
    end
  end, { 'i', 's' }),
  ['<BS>'] = cmp.mapping(function(fallback)
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Del>", true, true, true), "x")
    luasnip.jump(1)
  end, { "s" }),
  ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
}

local border_opts = {
  border = { { "╭" }, { "─" }, { "╮" }, { "│" }, { "╯" }, { "─" }, { "╰" }, { "│" }, },
  winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CmpSel,Search:None,NormalFloat:Normal",
  scrollbar = false,
  transparency = 0,
}



vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = border_opts.border,
    winhighlight = border_opts.winhighlight,
    close_events = { "BufHidden", "InsertLeave" },
  }
)

vim.diagnostic.config {
  float = border_opts,
}

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, border_opts
)

local icons = require("mood-scripts.icons")

cmp.setup({
  mapping = autocomplete_mappings,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  window = {
    documentation = border_opts,
    completion = border_opts,
  },
  sources = sources,
  formatting = {
    fields = { 'abbr', 'menu', 'kind' },
    format = function(entry, item)
      local icon = icons[item.kind] or icons[entry.source.name]

      item.menu = icon

      return item
    end,
  },
})

local ft = require('guard.filetype')
local diag_fmt = require('guard.lint').diag_fmt

-- See all formatters at https://github.com/nvimdev/guard.nvim
ft('ruby'):fmt('lsp'):lint('rubocop') -- Change fmt to 'rubocop' if this way does not work
ft('lua'):fmt('lsp')
ft('javascript,typescript,typescriptreact,javascriptreact'):fmt('prettier')

require('guard').setup({ fmt_on_save = false }) -- Format on save

-- Our typescript utils plugin. See the commands with SPC m on a javascript/typescript file.
require("typescript").setup({ server = { on_attach = on_attach } })

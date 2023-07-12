require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./vs-snippets" } })

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.set_preferences({ configure_diagnostics = false }) -- Use default LSP diagnostics

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
  on_attach = null_opts.on_attach,
  sources = {
    null_ls.builtins.formatting.prettier,
    -- SUPER IMPORTANT HERE, if this not works, change the solargraph formatting and diagnostics to true
    -- To make it work, you need to have fix the warning on your rubocop.yml
    null_ls.builtins.diagnostics.rubocop.with({
      command = "bundle",
      args = { "exec", "rubocop", "--format", "json", "--force-exclusion", "--stdin", "$FILENAME" },
      prefer_local = { "bin/" }
    })
  }
})

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }

  local bind = vim.keymap.set

  bind('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  bind('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  bind('n', 'gI', '<cmd>Telescope lsp_implementations<cr>', opts)
  bind('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', opts)
end

lsp.on_attach(on_attach)

local cmp = require('cmp')
local luasnip = require("luasnip")

lsp.ensure_installed({
  'tsserver',
  'lua_ls',
  'jsonls',
  'solidity',
  'yamlls',
  'jsonls',
  'solargraph'
})

lsp.configure('solidity', {
  settings = {
    solidity = { includePath = '',
      remapping = { ["@OpenZeppelin/"] = 'dependencies/OpenZeppelin/openzeppelin-contracts@4.6.0/' } }
  }
})

lsp.configure('solargraph', {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 50,
  },
  settings = {
    solargraph = {
      formatting = true, -- solargraph format is just faster
      useBundler = true,
      -- change to true if you want to use here instead of null-ls (null ls is faster for diagnostics)
      diagnostics = false,
    }
  }
})

lsp.nvim_workspace()

-- make cmp don't select first item
local cmp_mappings = lsp.defaults.cmp_mappings({
  -- Uncomment to input on select in autocomplete
  ['<Tab>'] = cmp.mapping.select_next_item({ select = true }),
  ['<S-Tab>'] = cmp.mapping.select_prev_item({ select = true }),
  ['<CR>'] = cmp.mapping.confirm(),
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
  ['<C-u>'] = cmp.mapping.scroll_docs( -4),
  ['<C-d>'] = cmp.mapping.scroll_docs(4),
})

local sources = { { name = "path" },
  { keyword_length = 2, name = "nvim_lsp" },
  { name = "buffer", option = { get_bufnrs = require('utils.valid_listed_buffers') } },
  { name = "luasnip", keyword_length = 2 },
  { name = "calc" }
}

lsp.setup_nvim_cmp({
  sources = sources,
  mapping = cmp_mappings,
  preselect = 'none', -- comment those 4 lines to select first on autocomplete.
  completion = {
      completeopt = 'menu,menuone,noinsert,noselect'
  },
})

lsp.setup()

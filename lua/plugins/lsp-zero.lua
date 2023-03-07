return { { 'VonHeikemen/lsp-zero.nvim', dependencies = {
  { 'neovim/nvim-lspconfig' }, -- Required
  { 'williamboman/mason.nvim' }, -- Optional
  { 'kosayoda/nvim-lightbulb' },
  { 'hrsh7th/cmp-calc' },
  { 'williamboman/mason-lspconfig.nvim' }, -- Optional
  -- Autocompletion
  { 'hrsh7th/nvim-cmp' }, -- Required
  { 'hrsh7th/cmp-nvim-lsp' }, -- Required
  { 'hrsh7th/cmp-buffer' }, -- Optional
  { 'hrsh7th/cmp-path' }, -- Optional
  { 'saadparwaiz1/cmp_luasnip' }, -- Optional
  { 'hrsh7th/cmp-nvim-lua' }, -- Optional
  { 'jose-elias-alvarez/null-ls.nvim' },

  -- Snippets
  { 'L3MON4D3/LuaSnip', build = "make install_jsregexp" }, -- Required
  { 'rafamadriz/friendly-snippets' }, -- Optional
}, config = function()
  require("user.lsp")
  local util = require("luasnip.util.util")
  local node_util = require("luasnip.nodes.util")

    require('nvim-lightbulb').setup({
      autocmd = {enabled = true},
      sign = {
        enabled = false,
        -- Priority of the gutter sign
        priority = 10,
      },
      status_text = {
        enabled = true,
        -- Text to provide when code actions are available
        text = "",
        -- Text to provide when no actions are available
        text_unavailable = ""
      },
    })

  require('luasnip').setup({
    parser_nested_assembler = function(_, snippet)
      local select = function(snip, no_move)
        snip.parent:enter_node(snip.indx)
        -- upon deletion, extmarks of inner nodes should shift to end of
        -- placeholder-text.
        for _, node in ipairs(snip.nodes) do
          node:set_mark_rgrav(true, true)
        end

        -- SELECT all text inside the snippet.
        if not no_move then
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "n",
            true
          )
          node_util.select_node(snip)
        end
      end
      function snippet:jump_into(dir, no_move)
        if self.active then
          -- inside snippet, but not selected.
          if dir == 1 then
            self:input_leave()
            return self.next:jump_into(dir, no_move)
          else
            select(self, no_move)
            return self
          end
        else
          -- jumping in from outside snippet.
          self:input_enter()
          if dir == 1 then
            select(self, no_move)
            return self
          else
            return self.inner_last:jump_into(dir, no_move)
          end
        end
      end
      -- this is called only if the snippet is currently selected.
      function snippet:jump_from(dir, no_move)
        if dir == 1 then
          return self.inner_first:jump_into(dir, no_move)
        else
          self:input_leave()
          return self.prev:jump_into(dir, no_move)
        end
      end
      return snippet
    end
  })
end } }

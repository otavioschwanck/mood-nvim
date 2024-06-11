return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			{ "williamboman/mason.nvim", event = "VeryLazy" }, -- Optional
			{ "hrsh7th/cmp-calc", event = "VeryLazy" },
			{ "nvimtools/none-ls.nvim", event = "VeryLazy" },
			{ "hrsh7th/cmp-cmdline", event = "VeryLazy" },
			{ "williamboman/mason-lspconfig.nvim", event = "VeryLazy" }, -- Optional
			-- Autocompletion
			{ "hrsh7th/nvim-cmp", event = "VeryLazy" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp", event = "VeryLazy" }, -- Required
			{ "hrsh7th/cmp-buffer", event = "VeryLazy" }, -- Optional
			{ "hrsh7th/cmp-path", event = "VeryLazy" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip", event = "VeryLazy" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua", event = "VeryLazy" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
		config = function()
			require("mood-scripts.ask_delete").require_ask_delete_if_fails(
				"user.lsp",
				"~/.config/nvim/lua/user/lsp.lua",
				"~/.config/nvim/extra/examples/lsp.lua"
			)
			local util = require("luasnip.util.util")
			local node_util = require("luasnip.nodes.util")

			require("luasnip").setup({
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
							vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
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
				end,
			})
		end,
	},
}

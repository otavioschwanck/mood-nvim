local plugins = {
	{ "junegunn/vim-easy-align", event = "VeryLazy" },
	{
		"otavioschwanck/arrow.nvim",
		event = "VeryLazy",
		opts = {
			always_show_path = false,
			show_icons = true,
			mappings = {
				edit = "e",
				delete_mode = "d",
				clear_all_items = "C",
				toggle = "s",
				open_vertical = "v",
				open_horizontal = "-",
				quit = "q",
			},
			leader_key = ";",
			buffer_leader_key = "m",
			after_9_keys = "zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- Please, don't pin more then 9 XD,
			save_key = function()
				return vim.loop.cwd() -- we use the cwd as the context from the bookmarks.  You can change it for anything you want.
			end,
			full_path_list = { "update_stuff" }, -- filenames on this list will ALWAYS show the file path too.
		},
		keys = {
			{
				"<C-j>",
				"<cmd>Arrow next_buffer_bookmark<CR>",
				desc = "Save Current Line",
			},
			{
				"<C-k>",
				"<cmd>Arrow prev_buffer_bookmark<CR>",
				desc = "Save Current Line",
			},
		},
	},
	{ "otavioschwanck/new-file-template.nvim", opts = {}, event = "VeryLazy" },
	{
		"stevearc/oil.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"s1n7ax/nvim-window-picker",
		event = "VeryLazy",
		config = function()
			require("window-picker").setup()
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			vim.opt.termguicolors = true

			require("tokyonight").setup({
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
				end,
			})
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
		config = function()
			require("smart-splits").setup({
				multiplexer_integration = true,
			})
		end,
	},
	{ "AndrewRadev/bufferize.vim", cmd = "Bufferize", event = "VeryLazy" },
	{ "otavioschwanck/tmux-awesome-manager.nvim", event = "VeryLazy" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		opts = {

			custom_highlights = function()
				return {
					NormalFloat = { link = "Normal" },
				}
			end,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = true,
				telescope = {
					enabled = true,
					style = "nvchad",
				},
			},
		},
	},
	{
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup({})
		end,
		event = "VeryLazy",
	},
	{ "tomlion/vim-solidity", event = "VeryLazy" },
	{ "rgroli/other.nvim", event = "VeryLazy" },
	{
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		config = function()
			local function on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "]g", api.node.navigate.git.next, opts("Next Git"))
				vim.keymap.set("n", "[g", api.node.navigate.git.prev, opts("Prev Git"))

				-- custom mappings
				vim.keymap.del("n", "]c", { buffer = bufnr })
				vim.keymap.del("n", "[c", { buffer = bufnr })
			end

			require("nvim-tree").setup({
				on_attach = on_attach,
				sort_by = "case_sensitive",
				view = {
					width = {
						min = 30,
						max = 60,
					},
				},
				renderer = {
					group_empty = true,
					root_folder_label = false,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},
	{
		"jose-elias-alvarez/typescript.nvim",
		event = "VeryLazy",
	},
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					enabled = false,
				},
				char = {
					keys = { "f", "F", "t", "T" },
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "emmanueltouzery/agitator.nvim", event = "VeryLazy" },
	{ "dhruvasagar/vim-table-mode", event = "VeryLazy" },
	{ "tpope/vim-commentary", event = "VeryLazy" },
	"axelvc/template-string.nvim",
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"vim-test/vim-test",
		init = function()
			vim.g["test#runner_commands"] = { "RSpec" }
		end,
		event = "VeryLazy",
	},
	{ "tpope/vim-eunuch", event = "VeryLazy" },
	{ "alvan/vim-closetag", event = "VeryLazy" },
	{ "tpope/vim-rails", event = "VeryLazy" },
	{ "vim-ruby/vim-ruby", event = "VeryLazy" },
	{ "farmergreg/vim-lastplace", event = "VeryLazy" },
	{ "svermeulen/vim-yoink", event = "VeryLazy" },
	{ "tpope/vim-fugitive", event = "VeryLazy" },
	{ "AndrewRadev/undoquit.vim", event = "VeryLazy" },
	{ "michaeljsmith/vim-indent-object", event = "VeryLazy" },
	{ "mbbill/undotree", cmd = "UndotreeToggle", event = "VeryLazy" },
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" },
	{ "Olical/vim-enmasse", event = "VeryLazy" },
	{ "rcarriga/nvim-notify", event = "VeryLazy" },
	{ "rafamadriz/friendly-snippets", event = "VeryLazy" },
	{ "ray-x/lsp_signature.nvim", event = "VeryLazy" },

	{ "windwp/nvim-ts-autotag", event = "VeryLazy" },
	{ "svermeulen/vim-subversive", event = "VeryLazy" },
	{ "beloglazov/vim-textobj-quotes", dependencies = { "kana/vim-textobj-user" }, event = "VeryLazy" },
	{ "kdheepak/lazygit.nvim", cmd = "LazyGit", event = "VeryLazy" },
	{ "nicwest/vim-camelsnek", event = "VeryLazy" },
	{ "AndrewRadev/sideways.vim", event = "VeryLazy" },
	{ "AndrewRadev/splitjoin.vim", event = "VeryLazy" },
	{ "AndrewRadev/switch.vim", event = "VeryLazy" },
	{ "folke/which-key.nvim", event = "VeryLazy" },
	{ "tpope/vim-abolish", event = "VeryLazy" },
	{ "tommcdo/vim-exchange", event = "VeryLazy" },
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
		event = "VeryLazy",
	},
	{ "MunifTanjim/nui.nvim", lazy = true, event = "VeryLazy" },
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override = {
					rb = {
						icon = "",
						color = "#ff8587",
						name = "DevIconRb",
					},
				},
			})
		end,
		event = "VeryLazy",
	},
	{ "moll/vim-bbye", event = "VeryLazy" },
	{ "otavioschwanck/ruby-toolkit.nvim", event = "VeryLazy" },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "VeryLazy",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({
				indent = { tab_char = { "▎" } },
				exclude = { filetypes = { "dashboard" } },
				scope = {
					highlight = highlight,
					show_start = false,
					show_end = false,
					include = { node_type = { ruby = { "if", "assignment", "pair", "call", "array" } } },
				},
			})

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	{ "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "mhartington/formatter.nvim", event = "VeryLazy" },
	{
		"prochri/telescope-all-recent.nvim",
		dependencies = { "kkharji/sqlite.lua" },
		event = "VeryLazy",
		config = function()
			require("telescope-all-recent").setup({
				pickers = {
					find_files = {
						disable = false,
						use_cwd = true,
						sorting = "recent",
					},
				},
			})
		end,
	},
}

local user_plugins = require("user.plugins")

for p = 1, table.getn(user_plugins) do
	table.insert(plugins, user_plugins[p])
end

vim.opt.number = true

return plugins

return {
	"otavioschwanck/telescope-alternate.nvim",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-lua/plenary.nvim",
			{
				"gbprod/yanky.nvim",
				config = function()
					local mapping = require("yanky.telescope.mapping")
					local utils = require("yanky.utils")
					local _, actions = pcall(require, "telescope.actions")

					require("yanky").setup({
						ring = {
							history_length = 50,
							storage = "shada",
							sync_with_numbered_registers = true,
						},
						preserve_cursor_position = {
							enabled = true,
						},
						picker = {
							telescope = {
								mappings = {
									default = mapping.put("p"),
									i = {
										["<C-p>"] = actions.move_selection_previous,
										["<C-n>"] = actions.move_selection_next,
										["<c-k>"] = mapping.put("P"),
										["<c-x>"] = mapping.delete(),
										["<c-r>"] = mapping.set_register("+"),
									},
									n = {
										p = mapping.put("p"),
										P = mapping.put("P"),
										d = mapping.delete(),
										r = mapping.set_register(utils.get_default_register()),
									},
								},
							},
						},
					})

					vim.api.nvim_set_keymap("n", "p", "<Plug>(YankyPutAfter)", {})
					vim.api.nvim_set_keymap("n", "P", "<Plug>(YankyPutBefore)", {})
					vim.api.nvim_set_keymap("x", "p", "<Plug>(YankyPutAfter)", {})
					vim.api.nvim_set_keymap("x", "P", "<Plug>(YankyPutBefore)", {})

					vim.api.nvim_set_keymap("n", "y", "<Plug>(YankyYank)", {})
					vim.api.nvim_set_keymap("x", "y", "<Plug>(YankyYank)", {})

					vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleForward)", {})
					vim.api.nvim_set_keymap("n", "<c-n>", "<Plug>(YankyCycleBackward)", {})
				end,
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
	},
}

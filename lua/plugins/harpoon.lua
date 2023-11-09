return {
	{
		"otavioschwanck/harpoon",
		lazy = false,
		config = function()
			require("harpoon").setup({
				global_settings = {
					mark_branch = false,
					tabline = true,
					tabline_icons = true,
					tabline_prefix = "   ",
					tabline_previous_buffer_text = "C-h",
					tabline_show_previous_buffer = true,
					tabline_show_current_buffer_not_added = true,
				},
			})

			require("telescope").load_extension("harpoon")
		end,
		keys = {
			{ "<C-s>", '<cmd>lua require("harpoon.mark").toggle_file()<cr>', desc = "Pin on Harpoon" },
		},
	},
}

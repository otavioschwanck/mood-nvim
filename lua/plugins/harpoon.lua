return {
	{
		"otavioschwanck/harpoon",
		config = function()
			require("harpoon").setup({
				global_settings = {
					mark_branch = false,
					tabline = true,
					tabline_icons = true,
					tabline_prefix = "   ",
				},
			})
		end,
		keys = {
			{ "<C-s>", '<cmd>lua require("harpoon.mark").toggle_file()<cr>', desc = "Pin on Harpoon" },
		},
	},
}

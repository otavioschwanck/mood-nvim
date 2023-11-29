return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					groups = {
						items = {
							require("bufferline.groups").builtin.pinned:with({ icon = "" }),
						},
					},
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "@storageclass",
							separator = false,
						},
					},
				},
			})
		end,
	},
}

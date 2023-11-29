return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				offsets = {
					{ filetype = "NvimTree", text = "File Explorer", highlight = "@storageclass", separator = false },
				},
			},
		},
	},
}

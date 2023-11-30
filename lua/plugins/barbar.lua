return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = false,
			auto_hide = false,
			tabpages = false,
			focus_on_close = "previous",
			sidebar_filetypes = {
				NvimTree = true,
			},
			highlight_inactive_file_icons = true,
			icons = {
				buffer_index = true,
				pinned = { button = "", filename = true },
			},
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
}

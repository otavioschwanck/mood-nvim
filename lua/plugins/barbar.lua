return {
	{
		"romgrk/barbar.nvim",
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = false,
			auto_hide = false,
			tabpages = false,
			focus_on_close = "previous",
			sidebar_filetypes = {
				NvimTree = { event = "BufWinLeave", text = " File Tree" },
			},
			highlight_inactive_file_icons = true,
			icons = {
				buffer_index = true,
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true },
					[vim.diagnostic.severity.WARN] = { enabled = true },
					[vim.diagnostic.severity.INFO] = { enabled = true },
					[vim.diagnostic.severity.HINT] = { enabled = false },
				},
				pinned = {
					button = "",
					filename = true,
				},
				separator_at_end = true,
			},
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
}

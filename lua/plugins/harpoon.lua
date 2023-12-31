return {
	{
		"otavioschwanck/harpoon",
		lazy = false,
		branch = "harpoon2",
		config = function()
			local harpoon = require("harpoon")
			local extensions = require("harpoon.extensions")

			harpoon:setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
				},
			})

			harpoon:extend(extensions.builtins.navigate_with_number())
		end,
	},
}

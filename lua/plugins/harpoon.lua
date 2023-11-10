return {
	{
		"otavioschwanck/harpoon",
		lazy = false,
		config = function()
			local function loadHarpoon()
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
			end

			local loadedHarpoon, _ = pcall(loadHarpoon)

			if not loadedHarpoon then
				require("notify")(
					"Failed to load harpoon.  Please install pynvim with: pip install pynvim or pip3 install pynvim"
				)
			end
		end,
		keys = {
			{ "<C-s>", '<cmd>lua require("harpoon.mark").toggle_file()<cr>', desc = "Pin on Harpoon" },
		},
	},
}

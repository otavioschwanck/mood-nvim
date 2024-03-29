return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = ""

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("SPC h l", "󰉙 " .. " Load Session", '<cmd>lua require("persistence").load() <CR>'),
				dashboard.button("SPC tab", " " .. " Git Status", "<cmd>Telescope git_status <CR>"),
				dashboard.button("SPC f r", " " .. " Recent files"),
				dashboard.button("SPC s p", " " .. " Find text"),
				dashboard.button("SPC h m", "󰑶 " .. " Mason (Manage LSP / Linters)", "<cmd>Mason<CR>"),
				dashboard.button(
					"SPC f p",
					" " .. " User Settings",
					"<cmd>lua require('mood-scripts.open-files').open_dotfiles()<CR>"
				),
				dashboard.button(
					"SPC h h",
					" " .. " Open Handbook (docs)",
					"<cmd>e ~/.config/nvim/handbook.md <CR>"
				),
				dashboard.button(
					"SPC h T",
					"ﲉ " .. " Open Tutorial for mooD",
					'<cmd>lua require("tutorial").start() <CR>'
				),
				dashboard.button("SPC h u", " " .. " Update mooD", "<cmd>UpdateMood<CR>"),
				dashboard.button("SPC q q", " " .. " Quit", "<cmd>qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

					local is_updated = string.match(
						string.gsub(vim.fn.system("cd ~/.config/nvim; git status"), "\n", ""),
						"Your branch is up to date"
					)

					if not is_updated then
						dashboard.section.footer.val =
							"  Mood has some updates.  Press SPC h u to install the latest updates."
					end
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}

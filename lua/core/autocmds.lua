local M = {}

function M.set_hl_for_floating_window(border_color)
	vim.api.nvim_set_hl(0, "NormalFloat", {
		link = "Normal",
	})
	vim.api.nvim_set_hl(0, "FloatBorder", {
		bg = "none",
		fg = border_color,
	})
end

function M.setup()
	vim.g.exiting = false
	vim.g.scheduled_save_session = false

	local autocommands = {
		{
			{ "FileType" },
			{ "qf" },
			function()
				vim.cmd("map <buffer> dd :RemoveQFItem<CR>")
			end,
		},
		{
			{ "VimLeavePre" },
			{ "*" },
			function()
				vim.g.exiting = true
			end,
		},
		{
			{ "FileType" },
			{ "TelescopePrompt" },
			function()
				vim.cmd("setlocal nocursorline")
			end,
		},
		{
			{ "BufWritePre" },
			{ "*" },
			function()
				vim.cmd('call mkdir(expand("<afile>:p:h"), "p")')
			end,
		},
		{
			{ "BufReadPost", "BufDelete" },
			{ "*" },
			function(ft)
				require("mood-scripts.auto-save-session").save_session(ft)
			end,
		},
	}

	for i = 1, #autocommands, 1 do
		vim.api.nvim_create_autocmd(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
	end

	vim.api.nvim_create_autocmd("BufRead", {
		pattern = "*.norg",
		command = "norm zR",
	})

	local function augroup(name)
		return vim.api.nvim_create_augroup("otavioschwanck_" .. name, { clear = true })
	end

	-- Check if we need to reload the file when it changed
	vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
		group = augroup("checktime"),
		command = "checktime",
	})

	-- resize splits if window got resized
	vim.api.nvim_create_autocmd({ "VimResized" }, {
		group = augroup("resize_splits"),
		callback = function()
			vim.cmd("tabdo wincmd =")
		end,
	})

	-- go to last loc when opening a buffer
	vim.api.nvim_create_autocmd("BufReadPost", {
		group = augroup("last_loc"),
		callback = function()
			local mark = vim.api.nvim_buf_get_mark(0, '"')
			local lcount = vim.api.nvim_buf_line_count(0)
			if mark[1] > 0 and mark[1] <= lcount then
				pcall(vim.api.nvim_win_set_cursor, 0, mark)
			end
		end,
	})

	-- close some filetypes with <q>
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup("close_with_q"),
		pattern = {
			"qf",
			"help",
			"man",
			"notify",
			"lspinfo",
			"spectre_panel",
			"startuptime",
			"tsplayground",
			"PlenaryTestPopup",
		},
		callback = function(event)
			vim.bo[event.buf].buflisted = false
			vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = { "LazyVimStarted" },
		callback = function()
			require("core.mappings").setup()
			require("mood-scripts.ask_delete").require_ask_delete_if_fails(
				"user.keybindings",
				"~/.config/nvim/lua/user/keybindings.lua",
				"~/.config/nvim/extra/examples/keybindings.lua"
			)
			require("user.config")
			require("mood-scripts.ask_delete").require_ask_delete_if_fails(
				"user.config",
				"~/.config/nvim/lua/user/config.lua",
				"~/.config/nvim/extra/examples/config.lua"
			)
			require("mood-scripts.setup-telescope").setup()

			local autocmd_harpoon = function(color, fill)
				vim.api.nvim_create_autocmd("ColorScheme", {
					group = vim.api.nvim_create_augroup("harpoon", { clear = true }),
					pattern = { "*" },
					callback = function()
						M.set_hl_for_floating_window(color)
						vim.cmd("highlight! TabLineFill guibg=" .. fill .. " guifg=NONE")
						vim.cmd("highlight! FloatBorder guifg=#494d64")
						vim.cmd("highlight! CmpSel guifg=#181926 guibg=#a6da95")

						vim.cmd("highlight NvimTreeFolderIcon guifg=#EED49F")
						vim.cmd("highlight NvimTreeFolderName guifg=#cad3f5")
						vim.cmd("highlight NvimTreeEmtpyFolderName guifg=#cad3f5")
						vim.cmd("highlight NvimTreeOpenedFolderName guifg=#cad3f5")
						vim.cmd("highlight NvimTreeSymlinkFolderName guifg=#cad3f5")
						vim.cmd("highlight NvimTreeTitle guifg=#EED49F guibg=" .. fill)

						local catppuccin_palette = require("catppuccin.palettes").get_palette()

						vim.api.nvim_set_hl(0, "WinBarPath", { fg = catppuccin_palette.overlay2 })
						vim.api.nvim_set_hl(0, "WinBarFileName", { fg = catppuccin_palette.text })
						vim.api.nvim_set_hl(0, "WinBarModified", { fg = catppuccin_palette.red })

						require("nvim-web-devicons").set_icon({
							rb = { icon = "", color = "#ff8587", name = "DevIconRb" },
							rake = { icon = "", color = "#ff8587", name = "DevIconRb" },
						})
					end,
				})
			end

			if string.match(vim.g.colors_name, "catppuccin") then
				autocmd_harpoon("#f5bde6", "#1e2030")
			else
				autocmd_harpoon("#7aa2f7", "#1e2030")
			end

			require("mood-scripts.statusline")()

			vim.fn.timer_start(1, function()
				vim.cmd("colorscheme " .. vim.g.colors_name)

				require("mood-scripts.bg-color").setup()

				vim.cmd("highlight Beacon guibg=white ctermbg=15")

				if string.match(vim.g.colors_name, "tokyonight") then
					vim.cmd("highlight LineNr guifg=#565f89")

					local tabColor = "#222437"
					local hint = "#1c9e89"

					vim.cmd("highlight CursorLineNr guifg=#7aa2f7")
					vim.cmd("highlight TreesitterContext guibg=" .. tabColor)
					vim.cmd("highlight TreesitterContextLineNumber gui=bold guifg=" .. hint)
				end

				if string.match(vim.g.colors_name, "catppuccin") then
					vim.cmd("highlight LineNr guifg=#8087a2")

					local tabColor = "#24273a"
					local hint = "#c6a0f6"

					vim.cmd("highlight CursorLineNr guifg=#f5bde6")
					vim.cmd("highlight TreesitterContext guibg=" .. tabColor)
					vim.cmd("highlight TreesitterContextLineNumber gui=bold guifg=" .. hint)

					local inactive_color = "#1e2030"

					-- current
					vim.cmd("highlight BufferCurrent guifg=#cad3f5 guibg=" .. tabColor .. " gui=bold")
					vim.cmd("highlight BufferCurrentIndex guifg=#cad3f5 guibg=" .. tabColor)

					-- errors
					vim.cmd("highlight BufferCurrentWARN guifg=#eed49f guibg=" .. tabColor)
					vim.cmd("highlight BufferCurrentERROR guifg=#ed8796 guibg=" .. tabColor)
					vim.cmd("highlight BufferCurrentHINT guifg=#8bd5ca guibg=" .. tabColor)
					vim.cmd("highlight BufferCurrentINFO guifg=#8bd5ca guibg=" .. tabColor)

					vim.cmd("highlight BufferCurrentIcon guifg=#cad3f5 guibg=" .. tabColor .. " gui=bold")
					vim.cmd("highlight BufferCurrentMod guifg=#eed49f guibg=" .. tabColor .. " gui=bold")
					vim.cmd("highlight BufferCurrentNumber guifg=#cad3f5 guibg=" .. tabColor .. " gui=bold")

					vim.cmd("highlight BufferCurrentSign guifg=#f5bde6 guibg=" .. tabColor)
					vim.cmd("highlight BufferCurrentRight guifg=#494d64 guibg=" .. tabColor)

					-- inactive
					vim.cmd("highlight BufferInactive guifg=#939ab7 guibg=" .. inactive_color)
					vim.cmd("highlight BufferInactiveIndex guifg=#939ab7 guibg=" .. inactive_color)
					vim.cmd("highlight BufferInactiveMod guifg=#eed49f guibg=" .. inactive_color)
					vim.cmd("highlight BufferInactiveSign guifg=#939ab7 guibg=" .. inactive_color)
					vim.cmd("highlight BufferInactiveIcon guifg=#939ab7 guibg=" .. inactive_color)

					vim.cmd("highlight BufferInactiveSign guifg=#494d64 guibg=" .. inactive_color)

					-- visible
					vim.cmd("highlight BufferVisible guifg=#939ab7 guibg=" .. inactive_color)
					vim.cmd("highlight BufferVisibleIndex guifg=#939ab7 guibg=" .. inactive_color)
					vim.cmd("highlight BufferVisibleMod guifg=#eed49f guibg=" .. inactive_color)
					vim.cmd("highlight BufferVisibleSign guifg=#939ab7 guibg=" .. inactive_color)
					vim.cmd("highlight BufferVisibleIcon guifg=#939ab7 guibg=" .. inactive_color)

					vim.cmd("highlight BufferVisibleSign guifg=#494d64 guibg=" .. inactive_color)
				end
			end)
		end,
	})

	-- wrap and check for spell in text filetypes
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup("wrap_spell"),
		pattern = { "gitcommit", "markdown" },
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
		end,
	})
end

return M

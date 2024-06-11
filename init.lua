vim.opt.termguicolors = true

local not_ok = {}

local function setup(path)
	local ok, res = pcall(require(path).setup)

	if not ok then
		table.insert(not_ok, path)

		if os.getenv("DEBUG") == "true" then
			print("[WARN] [" .. path .. "]: " .. res)
		end
	end

	return ok
end

vim.g.mapleader = " "

setup("mood-scripts.install-config")

-- vim script functions
setup("helpers.vim-functions")
setup("helpers.term-functions")
setup("core.plugins")

pcall(require, "user.before_start")

setup("core.set")
setup("core.globals")
setup("mood-scripts.quick-consult")

setup("core.start")

if #not_ok > 0 then
	print("Some Error happening when loading neovim: \n")
	print(
		"Try to restart Neovim.  If the error persist:\n1 - Run :Lazy install\n2 - Run :UpdateMood\n3 - Try to reinstall neovim.\n4 - Create an issue to help to fix\n5 - run neovim with DEBUG=true nvim"
	)
	print("Modules with errors: ")

	for i = 1, #not_ok, 1 do
		print(" - " .. not_ok[i])
	end
else
	require("mood-scripts.ask_delete").require_ask_delete_if_fails(
		"user.after_start",
		"~/.config/nvim/lua/user/after_start.lua",
		"~/.config/nvim/extra/examples/after_start.lua"
	)

	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			require("user.config")

			setup("core.autocmds")

			require("core.mappings").setup()

			require("mood-scripts.ask_delete").require_ask_delete_if_fails(
				"user.keybindings",
				"~/.config/nvim/lua/user/keybindings.lua",
				"~/.config/nvim/extra/examples/keybindings.lua"
			)

			require("mood-scripts.statusline")()

			require("mood-scripts.ask_delete").require_ask_delete_if_fails(
				"user.config",
				"~/.config/nvim/lua/user/config.lua",
				"~/.config/nvim/extra/examples/config.lua"
			)

			require("mood-scripts.setup-telescope").setup()

			setup("core.autocmds")
		end,
	})
end

local M = {}

function M.setup()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end

	vim.opt.runtimepath:prepend(lazypath)

	require("lazy").setup("plugins", {
		change_detection = {
			enabled = false,
			notify = false,
		},
		lazy = true,
	})
end

return M

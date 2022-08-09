local M = {}

local cmd = vim.api.nvim_create_autocmd
local autocommands = {
	{ {"CursorHold", "CursorHoldI", "FocusGained", "BufEnter"}, "*", function()vim.cmd("checktime") end },
	{ {"FileChangedShellPost"}, {"*"}, function() vim.cmd('echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None')end },
	{ {"BufReadPost"}, {"*"}, function() vim.cmd([[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])end },
	{ {"SwapExists"}, {"*"}, function() vim.cmd([[let v:swapchoice = "e"]])end },
	{ {"InsertLeave"}, {"*"}, function() vim.cmd('set nopaste') end },
	{ {"FileType"},  {"*"}, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end },
	{ {"BufEnter"}, {"*"}, function() vim.cmd('set signcolumn=yes') end },
	{ {"BufEnter"}, {"*"}, function() vim.cmd('let b:visit_time = localtime()') end },
	{ {"SwapExists"}, {"*"}, function() vim.cmd('let v:swapchoice = "e"') end },
  { {"BufWritePre"}, {"*"}, function() vim.cmd("call StripTrailingWhitespaces()") end },
  { {"BufWritePre"}, {"python"}, function() vim.cmd("Black") end },
  { {"BufWritePre"}, {"*"}, function() vim.cmd('call mkdir(expand("<afile>:p:h"), "p")') end },
  { {"TermOpen"}, {"*"}, function() vim.cmd('setlocal nobuflisted') end },
  { {"BufEnter"}, {"*"}, function() vim.cmd('ColorizerAttachToBuffer') end },
  { {"FileType"}, {"ruby", "eruby"}, function() vim.keymap.set('n', '<leader>d', ":call AddDebugger()<CR>", { buffer = vim.fn.bufnr()}) end },
  { {"VimLeavePre"}, {"*"}, function() require('mood-scripts.quit_neovim')() end },
  { {"BufReadPost"}, {"*"}, function() require('mood-scripts.command-on-start').autostart() end },
}

function M.setup()
	vim.cmd([[autocmd!]])

  for i = 1, #autocommands, 1 do
    cmd(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
  end
end

return M

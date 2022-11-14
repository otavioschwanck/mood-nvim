local M = {}

local cmd = vim.api.nvim_create_autocmd
local autocommands = {
	{ {"CursorHold", "CursorHoldI", "FocusGained", "BufEnter"}, {"*"}, function() if not vim.fn.bufexists('[Command Line]') then pcall(vim.cmd("checktime")) end end },
  {
    {"FileChangedShellPost"},
    {"*"},
    function()
      pcall(vim.cmd("e %"))
      vim.cmd('echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None')
      pcall(vim.cmd('Gitsigns refresh'))
    end,
  },
	{ {"BufReadPost"}, {"*"}, function() vim.cmd([[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])end },
	{ {"SwapExists"}, {"*"}, function() vim.cmd([[let v:swapchoice = "e"]])end },
	{ {"InsertLeave"}, {"*"}, function() vim.cmd('set nopaste') end },
	{ {"FileType"},  {"*"}, function() vim.cmd('setlocal shiftwidth=2 tabstop=2') end },
	{ {"BufEnter"}, {"*"}, function() vim.cmd('set signcolumn=yes') end },
	{ {"BufEnter"}, {"*.html.erb"}, function() vim.cmd('TSBufDisable highlight') end }, -- temporary disable tree-sitter for erb files
	{ {"BufEnter"}, {"*"}, function() vim.cmd('let b:visit_time = localtime()') end },
	{ {"SwapExists"}, {"*"}, function() vim.cmd('let v:swapchoice = "e"') end },
  { {"BufWritePre"}, {"*"}, function() vim.cmd("call StripTrailingWhitespaces()") end },
  { {"BufWritePre"}, {"python"}, function() vim.cmd("Black") end },
  { {"BufWritePre"}, {"*"}, function() vim.cmd('call mkdir(expand("<afile>:p:h"), "p")') end },
  { {"TermOpen"}, {"*"}, function() vim.cmd('setlocal nobuflisted') end },
  { {"BufEnter"}, {"*"}, function() vim.cmd('ColorizerAttachToBuffer') end },
  { {"FileType"}, {"qf"}, function() vim.cmd('map <buffer> dd :RemoveQFItem<CR>') end },
  { {"TermOpen"}, {"*"}, function() vim.cmd('setlocal nonumber norelativenumber') end },


  -- autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>
}

function M.setup()
	vim.cmd([[autocmd!]])

  for i = 1, #autocommands, 1 do
    cmd(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
  end
end

return M

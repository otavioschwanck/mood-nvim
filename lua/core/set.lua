local M = {}

local set = vim.api.nvim_set_option

function M.setup()
  set('undofile', true)
  set('nu', true)

	set('hidden', true)
	set('shiftwidth', 2)
	set('tabstop', 2)
	set('compatible', false)
	set('ic', true)

	vim.cmd('syntax enable')
	set('fileencodings', 'utf-8,sjis,euc-jp,latin')
	set('encoding', 'utf-8')
	set('title', true)
	set('autoindent', true)
	set('hlsearch', true)
	set('showcmd', true)
	set('updatetime', 200)
	set('laststatus', 2)
	set('scrolloff', 10)
	set('expandtab', true)
	set('backupskip', '/tmp/*,/private/tmp/*')

	vim.cmd([[set shortmess+=c]])

	set('timeoutlen', 400)
	set('backup', false)
	set('writebackup', false)
	set('inccommand', 'split')
	set('t_BE', '')
	set('sc', false)
	set('ru', false)
	set('sm', false)
	set('lazyredraw', true)
	set('ignorecase', true)
	set('smarttab', true)

	vim.cmd([[filetype plugin indent on]])
	vim.cmd([[filetype plugin on]])

	set('ai', true)
	set('si', true)

	set('backspace', 'start,eol,indent')
  set('showtabline', 0)

	vim.cmd('set path+=**')
	vim.cmd('set wildignore+=*/node_modules/*')
	vim.cmd('set formatoptions+=r')

	set('cursorline', true)

	vim.cmd('highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40')

	vim.cmd('highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000')

	vim.cmd([[
	  augroup BgHighlight
	  	autocmd!
	  	autocmd WinEnter * set cul
	  	autocmd WinLeave * set nocul
	  augroup END
	]])

	set('suffixesadd', '.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md')

	set('splitright', true)
	set('splitbelow', true)

	set('background', 'dark')
	set('termguicolors', true)
	set('confirm', true)
	set('clipboard', 'unnamed,unnamedplus')
end

return M

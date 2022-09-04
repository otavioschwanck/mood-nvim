local M = {}

function M.setup()
  vim.cmd([[
    if has("nvim-0.5.0") || has("patch-8.1.1564")
      set signcolumn=number
    else
      set signcolumn=yes
    endif

    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1) :
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    nmap <silent> [e <Plug>(coc-diagnostic-prev)
    nmap <silent> ]e <Plug>(coc-diagnostic-next)

    nmap <silent> gt :Telescope coc type_definitions<CR>
    nmap <silent> gI :Telescope coc implementations<CR>
    nmap <silent> gr :call TelescopeGoToReferences()<CR>

    function! TelescopeGoToDefinition()
      let ret = execute("Telescope coc definitions")
      echom ret
      if ret =~ "Error" || ret =~ "no definitions found" || ret =~ "server does not support"
        execute "AnyJump"
      endif
    endfunction

    function! TelescopeGoToReferences()
      let ret = execute("Telescope coc references")
      echom ret
      if ret =~ "Error" || ret =~ "no references found" || ret =~ "server does not support"
        execute "AnyJump"
      endif
    endfunction

    let g:symbols_without_lsp_regexp = {}
    let g:symbols_without_lsp_regexp.solidity = 'function | modifier  '
    let g:symbols_without_lsp_regexp.default = 'def  '
    let g:symbols_without_lsp_regexp.empty = '^> | ^E | Failure/Error'

    function! TelescopeDocumentSymbols()
      let ret = execute("Telescope coc document_symbols")
      echom ret
      if ret =~ "Error" || ret =~ "server does not support"
        let buftype = getbufvar('', '&filetype', 'ERROR')

        if buftype == ''
          let buftype = 'empty'
        endif

        echo buftype

        let command = get(g:symbols_without_lsp_regexp, buftype, g:symbols_without_lsp_regexp.default)

        execute "normal! :Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case \<CR>" . command
        startinsert
      endif
    endfunction

    nnoremap <silent> gd :call TelescopeGoToDefinition()<CR>
    vmap <silent> gd :AnyJumpVisual<CR>


    function! ShowDocumentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

    nnoremap <silent> K :call ShowDocumentation()<CR>

    autocmd CursorHold * silent call CocActionAsync('highlight')

    xmap <leader>cf  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    xmap <leader>ca  <Plug>(coc-codeaction-selected)

    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
      nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
      inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
      vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
    endif

    command! -nargs=0 Format :call CocActionAsync('format')

    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

    inoremap <silent><expr> <C-j>
          \ coc#expandable() && !coc#jumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ coc#jumpable() ? "\<C-r>=coc#snippet#next()\<CR>" : "\<C-j>"
  ]])
end

function M.setupPlugins()
  if vim.g.coc_global_extensions == nil or vim.g.coc_global_extensions == {} then
    vim.g.coc_global_extensions = {
      'coc-html', 'coc-css', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-diagnostic', 'coc-solargraph',
      'coc-emmet', 'coc-yaml', 'coc-snippets', 'coc-jedi', 'coc-solidity', 'coc-calc'
    }
  end
end

return M

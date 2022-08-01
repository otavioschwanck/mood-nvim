local M = {}

function M.setup()
  vim.cmd([[
    function! OpenConsultationWindow() abort
      let filepath = shellescape(fnamemodify('~/.nvim-quick-consult', ':p'))[1:-2]
      let filepath_of_filetype = shellescape(fnamemodify('~/.nvim-quick-consult-filetype', ':p'))[1:-2]

      if(filereadable(filepath))
        let ui = nvim_list_uis()[0]

        let width = ui.width / 2 - 2
        let height = len(readfile(filepath))

        let buf = nvim_create_buf(v:false, v:true)

        let file = readfile(filepath)
        call nvim_buf_set_lines(buf, 0, len(file), 0, file)

        let closingKeys = ['<Esc>', '<CR>', 'q', '<C-g>']
        for closingKey in closingKeys
          call nvim_buf_set_keymap(buf, 'n', closingKey, ':close<CR>', {'silent': v:true, 'nowait': v:true, 'noremap': v:true})
        endfor

        let win_count = luaeval('require("utils.buf_count")()')

        if win_count
          let col = (ui.width/2)
        else
          let col = 2
        endif

        let opts = {'relative': 'editor',
              \ 'width': width,
              \ 'height': height,
              \ 'col': col,
              \ 'row': 3,
              \ 'anchor': 'NW',
              \ 'style': 'minimal',
              \ 'border': 'single'
              \ }
        let win = nvim_open_win(buf, 1, opts)

        execute "set filetype=" . readfile(filepath_of_filetype)[0]
      else
        lua require('notify')("Nothing to consult.", 'warn', { title='Quick Consult' })
      endif
    endfunction

    function! GetVisualSelection()
        let [line_start, column_start] = getpos("'<")[1:2]
        let [line_end, column_end] = getpos("'>")[1:2]
        let lines = getline(line_start, line_end)
        if len(lines) == 0
            return ''
        endif
        let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][column_start - 1:]
        return join(lines, "\n")
    endfunction

    function SaveSelectionToQuickConsult()
      echo 'Overwrite current consult? y/n '
      let l:answer = nr2char(getchar())

      if l:answer ==? 'y'
        let filepath = shellescape(fnamemodify('~/.nvim-quick-consult', ':p'))[1:-2]
        let filepath_of_filetype = shellescape(fnamemodify('~/.nvim-quick-consult-filetype', ':p'))[1:-2]

        let selected_text = GetVisualSelection()
        call writefile(split(selected_text, "\n"), filepath)
        call writefile([&filetype], filepath_of_filetype)
        lua require('notify')("Saved!", 'info', { title='Quick Consult' })
      elseif l:answer ==? 'n'
        return 0
      else
        lua require('notify')('Please enter "y" or "n"', 'info', { title='Quick Consult' })
        return SaveSelectionToQuickConsult()
      endif
    endfunction

    function AppendSelectionToQuickConsult()
      let filepath = shellescape(fnamemodify('~/.nvim-quick-consult', ':p'))[1:-2]

      let selected_text = GetVisualSelection()
      call writefile(split(selected_text, "\n"), filepath, "a")
      lua require('notify')("Text added to quick consult!", 'info', { title='Quick Consult' })
    endfunction

    function SaveClipboardToQuickConsult()
      let filepath = shellescape(fnamemodify('~/.nvim-quick-consult', ':p'))[1:-2]

      let text = getreg("\"")

      call writefile(split(text, "\n"), filepath)
      lua require('notify')("Saved!", 'info', { title='Quick Consult' })
    endfunction

    function AppendClipboardToQuickConsult()
      let filepath = shellescape(fnamemodify('~/.nvim-quick-consult', ':p'))[1:-2]

      let text = getreg("\"")

      call writefile(split(text, "\n"), filepath, "a")

      lua require('notify')("Text Added to quick consult!", 'info', { title='Quick Consult' })
    endfunction
  ]])
end

return M

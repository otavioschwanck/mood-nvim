local M = {}

function M.setup()
  -- TODO: Migrate this functions to lua

  vim.cmd([[
    function! WordForGq()
      let l:word = substitute(getreg('"'), "\\", "\\\\", "gre")
      let l:word = substitute(l:word, "[", "\\\\[", "gre")
      let l:word = substitute(l:word, "]", "\\\\]", "gre")
      let l:word = substitute(l:word, "/", "\\\\/", "gre")
      let l:word = substitute(l:word, "\\*", "\\\\*", "gre")
      let l:word = substitute(l:word, "\\$", "\\\\$", "gre")
      let l:word = substitute(l:word, "\\~", "\\\\~", "gre")
      let l:word = substitute(l:word, "\\^", "\\\\^", "gre")
      let l:word = substitute(l:word, "\\.", "\\\\.", "gre")

      return l:word
    endfunction

    function OpenCommand()
      if &filetype == 'dashboard'
        lua require('mood-scripts.command-on-start').autostart()
      endif
    endfunction

    function GetClassName()
      let filetype = getbufvar('', '&filetype', 'ERROR')

      if filetype == 'ruby'
        let modules = getline(1, '$')->filter({_,line -> line =~ 'module\|class \w'})

        let class_name = ''
        let keep_while = 1
        let index = 0

        if modules == []
          let keep_while = 0
        endif

        while keep_while == 1
          let kind = split(modules[index], ' ')[0]
          let name = split(modules[index], ' ')[1]

          let class_name = class_name . name

          if kind == 'class' || index >= (len(modules) - 1)
            let keep_while = 0
          else
            let index = index + 1
            let class_name = class_name . '::'
          endif
        endwhile

        call setreg('+', class_name)
        call setreg('*', class_name)

        if class_name != ''
          echo "Copied to clipboard: " . class_name
        else
          echo "No class or module found"
        endif
      endif
    endfunction

    function BetterMove()
      let current_folder = expand('%:p:h')

      call feedkeys(":Move " . current_folder . "/", 'n')

      call timer_start(500, {-> execute("doautocmd BufNew") })
    endfunction

    function BetterRename()
      let current_file = expand("%p")
      let current_file_name = expand("%:t")
      let new_name = input("New name for " . current_file_name . ": ", current_file_name)
      let current_folder = expand('%:p:h')

      if(new_name != '' && new_name != current_file_name)
        call feedkeys(":saveas " . current_folder . "/" . new_name . "\<CR>", "n")
        call delete(current_file)
        call feedkeys(":bd! #\<CR>")
        call feedkeys(":e #\<CR>")

        lua require('notify')("File renamed from " .. vim.api.nvim_eval('current_file_name') .. " to " .. vim.api.nvim_eval('new_name'), 'info', { title='File Management' })

        call timer_start(500, {-> execute("doautocmd BufNew") })
      endif
    endfunction

    function BetterCopy()
      let current_folder = expand('%:p:h')

      call feedkeys(":saveas " . current_folder . "/", 'n')

      call timer_start(500, {-> execute("doautocmd BufNew") })
    endfunction

    function BetterDelete()
      echo 'Really want to delete current file? y/n '
      let l:answer = nr2char(getchar())

      if l:answer ==? 'y'
        execute "normal! :Delete!\<CR>"
        lua require('notify')("File deleted.", 'info', { title='File Management' })
      elseif l:answer ==? 'n'
        return 0
      else
        echo 'Please enter "y" or "n"'
        return BetterDelete()
      endif
    endfunction
    function Setreg(regname, regval)
      exe "let @".a:regname." = '".a:regval."'"
    endfunction

    function CopyRelativePath()
      let value = fnamemodify(expand("%"), ":~:.")
      call Setreg("*", value)
      call Setreg("+", value)
      echom "Yanked: " . value
    endfunction

    function CopyRelativePathWithLine()
      let file = fnamemodify(expand("%"), ":~:.")
      let line = line(".")

      let value = file . ":" . line

      call Setreg("*", value)
      call Setreg("+", value)
      echom "Yanked: " . value
    endfunction

    function CopyFullPath()
      let value = expand("%:p")
      call Setreg("*", value)
      call Setreg("+", value)
      echom "Yanked: " . value
    endfunction

    function Maximize()
      if expand('%') != '' && (&buftype != '' || &filetype != '') && &buftype != 'nofile' && &buftype != 'qf' && &buftype != 'quickfix'
        lua require('utils.maximize')()
      else
        execute "norm! \<CR>"
      endif
    endfunction

    function! SplitTermStrategy(cmd)
      execute "call OpenTerm(a:cmd, 'Vim Test', 2, 0)"
    endfunction

    function! StripTrailingWhitespaces()
      " save last search & cursor position
      let _s=@/
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      let @/=_s
      call cursor(l, c)
    endfunction

    function AddDebugger()
      let buftype = getbufvar('', '&filetype', 'ERROR')

      if buftype == "ruby"
        execute "norm O" . g:ruby_debugger
      endif

      if buftype == "eruby"
        execute "norm O<% " . g:ruby_debugger . " %>"
      endif

      write
      execute "stopinsert"
    endfunction

    function ClearDebugger()
      let buftype = getbufvar('', '&filetype', 'ERROR')

      if buftype == "ruby"
        execute "%s/.*" . g:ruby_debugger . "\\n//gre"
      endif

      if buftype == "eruby"
        execute "%s/.*<% " . g:ruby_debugger . " %>\\n//gre"
      endif
      write
    endfunction

    function FindInFolder(folder, title)
      if isdirectory(a:folder)
        execute "lua require'telescope.builtin'.find_files({ cwd = '" . a:folder . "', prompt_title = '" . a:title . "' })"
      else
        echo "Directory: '" . a:folder . "' not found in this project..."
      endif
    endfunction

    function s:CleanConfigs()
      execute "!sh ~/.config/nvim/bin/clean.sh"
    endfunction


    function s:UpdateMood()
      execute "!cd ~/.config/nvim; git pull origin main -f"
      execute "PackerClean"
      execute "PackerInstall"
      execute "PackerUpdate"
    endfunction

    command! CleanConfigs :call s:CleanConfigs()
    command! UpdateMood :call s:UpdateMood()

    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction
  ]])
end

return M

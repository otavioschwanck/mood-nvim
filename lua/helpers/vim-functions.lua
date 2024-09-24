local M = {}

function M.close_term()
  if vim.o.buftype == "terminal" then
    vim.cmd("close")
  end
end

function M.setup()
  -- TODO: Migrate this functions to lua

  vim.cmd([[
    function OpenTestAlternateAndSplit()
      let win_count = luaeval('require("utils.buf_count")()')
      let test_path = eval('rails#buffer().alternate()')

      execute "normal! \<C-w>o"

      execute "norm \<C-w>v"

      execute "call OpenTestAlternate()"

      if test_path =~ 'app/'
        execute "norm \<C-w>x"
      endif
    endfunction

    function OpenTestAlternate()
      let test_path = eval('rails#buffer().alternate()')

      execute "e " . test_path

      if !filereadable(test_path) && join(getline(1,'$'), "\n") == ''
        if test_path =~ "spec/"
          lua require("utils.insert_rspec")()
        endif
      endif
    endfunction

    function! RemoveQFItem()
      let curqfidx = line('.') - 1
      let qfall = getqflist()
      call remove(qfall, curqfidx)
      call setqflist(qfall, 'r')
      execute curqfidx + 1 . "cfirst"
      :copen
    endfunction

    command! RemoveQFItem :call RemoveQFItem()

    function SearchClassName()
      let class_name = GetClassName()

      if class_name != ""
        execute ":Telescope grep_string search=" . class_name
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

          return class_name
        else
          echo "No class or module found"

          return ""
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
        call feedkeys(":e\<CR>")

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

    function! TermStrategy(cmd)
      if a:cmd =~ 'rspec'
        if filereadable("/tmp/quickfix.out")
          call delete("/tmp/quickfix.out")
        endif

        lua require("mood-scripts.rspec").clear_diagnostics()
        lua require("mood-scripts.rspec").wait_quickfix_to_insert_diagnostics()
      endif

      lua require("tmux-awesome-manager").execute_command({ cmd = vim.api.nvim_eval("a:cmd"), name = "Tests...", open_as = 'pane', size = '50%', focus_when_call = false })
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

      if buftype == "javascript" || buftype == "javascriptreact" || buftype == "typescript" || buftype == "typescriptreact"
        echo "j = down. k = up: "
        let direction = nr2char(getchar())

        execute 'norm 0\"dY'

        call setreg("d", substitute(getreg("d"), "'", "\\\\'", "g"))

        if direction == "j"
          execute "norm! oconsole.log('DEBUGGER', '\<esc>\"dpa', );\<esc>h"
          execute "startinsert"
        elseif direction == "k"
          execute "norm! Oconsole.log('DEBUGGER', '\<esc>\"dpa', );\<esc>h"
          execute "startinsert"
        else
          lua require('vim-notify')('Wrong Direction!', 'error', { title = 'mooD' })
        end
      else
        write
        execute "stopinsert"
      endif
    endfunction

    function ClearDebugger()
      let buftype = getbufvar('', '&filetype', 'ERROR')

      if buftype == "ruby"
        execute "%s/.*" . g:ruby_debugger . "\\n//gre"
      endif

      if buftype == "javascript" || buftype == "javascriptreact" || buftype == "typescript" || buftype == "typescriptreact"
        execute "%s/.*console.log(\\_.\\{-\\});\\n//gre"
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
      execute "!sh " .. fnamemodify(expand("$MYVIMRC"), ":h") .. "/bin/clean.sh"
    endfunction

    function s:CleanBasicConfigs()
      execute "!sh " .. fnamemodify(expand("$MYVIMRC"), ":h") .. "/bin/basic_clean.sh"
    endfunction

    function s:CleanAllExceptConfig()
      execute "!sh " .. fnamemodify(expand("$MYVIMRC"), ":h") .. "/bin/clean_all_except_config.sh"
    endfunction

    function s:UpdateMood()
      execute "!cd " .. fnamemodify(expand("$MYVIMRC"), ":h") .. ";git checkout HEAD .;git pull origin main -f"
      execute "Lazy load all"
      execute "Lazy restore"
      execute "Lazy load all"
      execute "Lazy install"
    endfunction

    command! CleanConfigs :call s:CleanConfigs()
    command! CleanConfigsExceptUsers :call s:CleanBasicConfigs()
    command! CleanConfigsExceptBaseConfig :call s:CleanAllExceptConfig()
    command! UpdateMood :call s:UpdateMood()

    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction
  ]])
end

return M

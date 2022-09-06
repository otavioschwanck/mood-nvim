local M = {}

function M.setup()
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
          execute "norm itemplate_test\<C-j>"
        else
          execute "norm iminitest\<C-j>"
        endif
      endif
    endfunction

    function HideTerminalWindowOrNoh()
      if &buftype == 'terminal'
        let win_count = luaeval('require("utils.buf_count")()')

        if win_count <= 1
          if(g:term_as_full_screen_tabs > 0 && tabpagenr() != 1)
            execute "tabclose"
          else
            lua require("utils.goto_last_file_buffer")()
          endif
        else
          if b:common_open == 1
            execute "norm! \<C-w>W"
          else
            try
              execute "close"
            catch /.*/
              call timer_start(10, {-> execute("call HideTerminalWindowOrNoh()") })
            endtry
          endif
        endif
      endif
    endfunction

    function RunLastTermCommand()
      execute "call OpenTerm(g:last_term_command[0], g:last_term_command[1], g:last_term_command[2], g:last_term_command[3])"
    endfunction

    function OpenTermFromLastCommand()
      let bnr = v:lua.require('mood-scripts.last_open_terminal')()

      if(g:term_as_full_screen_tabs > 0)
        let change_buffer_command = "tab sb "
      else
        let change_buffer_command = "bel sb "
      endif

      if (bnr > 0)
        execute change_buffer_command . " " . bufname(bnr)
        startinsert

        let b:common_open = 0
        execute "SendHere"
      else
        lua require('notify')("Last Terminal not found.  Maybe its closed?", 'warn', { title='Terminal Management' })
      endif
    endfunction

    function OpenTerm(command, name, unique, close_after_create)
      let p_name = split(getcwd(), "/")

      if(g:term_as_full_screen_tabs > 0)
        let change_buffer_command = "tab sb "
        let term_command = "TTerm"

        let b:common_open = 0
      else
        let change_buffer_command = "bel sb "
        let term_command = "Term"

        let b:common_open = 0
      endif

      if a:name != 'Quick Term'
        let g:last_term_command = [a:command, a:name, a:unique, a:close_after_create]
      end

      if len(p_name) > 0
        let full_name = p_name[-1] . " " . a:name
      else
        let full_name = a:name
      endif

      let bnr = bufexists(full_name)

      if bnr > 0 && a:unique == 1
        execute change_buffer_command . " " . full_name

        echo full_name . " exists.  Focusing."
        startinsert

        let b:common_open = 0
      elseif bnr > 0 && a:unique == 2
        execute change_buffer_command . " " . full_name

        lua require('mood-scripts.command-on-start').kill_single_terminal(vim.fn.bufnr(vim.api.nvim_eval('full_name')))

        let command_to_run = "call OpenTerm('" . a:command . "', '" . a:name . "', '" . a:unique . "', '" . a:close_after_create . "')"

        call timer_start(300, {-> execute(command_to_run) })
      else
        if bnr > 0
          let new_number = 0

          while bnr > 0
            let bnr = bufexists(full_name . " - " . new_number)

            if bnr > 0
              let new_number = new_number + 1
            endif
          endwhile

          execute term_command . " " . a:command
          execute "file! " . full_name . " - " . new_number
          execute "SendHere"

          let b:common_open = 0
        else
          execute term_command . " " . a:command

          execute "file! " . full_name
          execute "SendHere"

          let b:common_open = 0
        end

        if a:close_after_create == 1
          execute "close"

          if a:name != 'Quick Term'
            lua require('notify')(vim.api.nvim_eval('a:name') .. " is being executed in background.", 'info', { title='Terminal Management' })
          endif

          stopinsert
        end
      endif
    endfunction

    function ResetRailsDb(command)
      call KillRubyInstances()

      execute "call OpenTerm('" . a:command  . "', 'DB Reset', 2, 0)"
    endfunction

    function KillRubyInstances()
      execute "silent !killall -9 rails ruby spring bundle"

      lua require('notify')('Ruby Instances killed.', 'info', { title='mooD' })

      call timer_start(2000, {-> execute("LspStart solargraph") })
    endfunction
  ]])
end

return M

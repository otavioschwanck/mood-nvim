local M = {}

function M.setup()
  local autocommands = {
    { { "FileType" },    { "qf" },              function() vim.cmd('map <buffer> dd :RemoveQFItem<CR>') end },
    { { "FileType" },    { "TelescopePrompt" }, function() vim.cmd('setlocal nocursorline') end },
    { { "BufWritePre" }, { "*" },               function() vim.cmd('call mkdir(expand("<afile>:p:h"), "p")') end },
  }

  for i = 1, #autocommands, 1 do
    vim.api.nvim_create_autocmd(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
  end

  local function augroup(name)
    return vim.api.nvim_create_augroup("otavioschwanck_" .. name, { clear = true })
  end

  -- Check if we need to reload the file when it changed
  vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
  })

  -- Highlight on yank
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- resize splits if window got resized
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
      vim.cmd("tabdo wincmd =")
    end,
  })

  -- go to last loc when opening a buffer
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function()
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      local lcount = vim.api.nvim_buf_line_count(0)
      if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })

  -- close some filetypes with <q>
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
      "qf",
      "help",
      "man",
      "notify",
      "lspinfo",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "PlenaryTestPopup",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })

  vim.api.nvim_create_autocmd('User', {
    once = true,
    pattern = { 'LazyVimStarted' },
    callback = function()
      require('core.mappings').setup()
      require('user.keybindings')
      require('user.config')

      require('barbar').setup({
        animation = false,
        hide = {extensions = true},
        icons = {
          -- Configure the base icons on the bufferline.
          buffer_index = false,
          buffer_number = false,
          button = '',
          -- Enables / disables diagnostic symbols
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
            [vim.diagnostic.severity.WARN] = {enabled = false},
            [vim.diagnostic.severity.INFO] = {enabled = false},
            [vim.diagnostic.severity.HINT] = {enabled = false},
          },
          filetype = {
            custom_colors = false,
            enabled = true,
          },
          separator = {left = '', right = '▕'},
          modified = {button = '●'},
          pinned = {buffer_index = true, filename = true, button = '', separator = { right = '▕', left = ''} },
          alternate = {filetype = {enabled = false}},
          current = {buffer_index = false},
          inactive = {button = '', separator = {left = '', right = '▕'}},
          visible = {modified = {buffer_number = false}},
        },
        sidebar_filetypes = {
          ['neo-tree'] = {event = 'BufWipeout'},
        },
        exclude_ft = {'netrw'},
        highlight_visible = false,
      })

      require("mood-scripts.bg-color").setup()

      vim.cmd('call timer_start(5, {-> execute("colorscheme ' .. (vim.g.colors_name or 'tokyonight-moon') .. '") })')
      vim.fn.timer_start(50, function()
        require('mood-scripts.statusline')()
        vim.cmd('highlight Beacon guibg=white ctermbg=15')

        if string.match(vim.g.colors_name, 'tokyonight') then
          vim.cmd('highlight LineNr guifg=#565f89')

          local tabColor = '#222437'
          local hint = "#1c9e89"

          vim.cmd("highlight CursorLineNr guifg=#7aa2f7")
          vim.cmd("highlight TreesitterContext guibg=" .. tabColor)
          vim.cmd("highlight TreesitterContextLineNumber gui=bold guifg=" .. hint)
        end
      end)
    end,
  })

  -- wrap and check for spell in text filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })
end

return M

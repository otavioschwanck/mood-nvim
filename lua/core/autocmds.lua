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

      require('bufferline').setup({
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
            -- Sets the icon's highlight group.
            -- If false, will use nvim-web-devicons colors
            custom_colors = false,

            -- Requires `nvim-web-devicons` if `true`
            enabled = true,
          },
          separator = {left = '', right = ''},

          -- Configure the icons on the bufferline when modified or pinned.
          -- Supports all the base icon options.
          modified = {button = '●'},
          pinned = {buffer_index = true, filename = true, button = '車', separator = { right = ''} },

          -- Configure the icons on the bufferline based on the visibility of a buffer.
          -- Supports all the base icon options, plus `modified` and `pinned`.
          alternate = {filetype = {enabled = false}},
          current = {buffer_index = false},
          inactive = {button = '', separator = {left = '', right = ''}},
          visible = {modified = {buffer_number = false}},
        },
        -- icon_pinned = '󰐃',
        exclude_ft = {'netrw'},
        -- closable = false,
        highlight_visible = false,
      })

      vim.cmd('call timer_start(50, {-> execute("colorscheme ' .. vim.g.colors_name .. '") })')
      vim.fn.timer_start(50, function()
        require('mood-scripts.statusline')()
        vim.cmd('highlight Beacon guibg=white ctermbg=15')

        if string.match(vim.g.colors_name, 'tokyonight') then
          vim.cmd('highlight LineNr guifg=#565f89')

          local tabColor = '#24283b'
          local barColor = '#333749'
          local inactiveColor = '#292e42'
          local dark5 = "#636a8d"
          local error = "#b64448"
          local hint = "#1c9e89"
          local info = "#129cb8"
          local warning = "#ba945f"

          vim.cmd("highlight BufferInactive guibg=" .. inactiveColor .. " guifg=" .. dark5)
          vim.cmd("highlight BufferInactiveERROR guibg=" .. inactiveColor .. " guifg=" .. error)
          vim.cmd("highlight BufferInactiveHINT guibg=" .. inactiveColor .. " guifg=" .. hint)
          vim.cmd("highlight BufferInactiveINFO guibg=" .. inactiveColor .. " guifg=" .. info)
          vim.cmd("highlight BufferInactiveWARN guibg=" .. inactiveColor .. " guifg=" .. warning)
          vim.cmd("highlight BufferInactiveIndex guibg=" .. inactiveColor)
          vim.cmd("highlight BufferInactiveMod guibg=" .. inactiveColor .. " guifg=" .. warning)
          vim.cmd("highlight BufferInactiveSign guibg=" .. inactiveColor)
          vim.cmd("highlight BufferInactiveTarget guibg=" .. inactiveColor)

          vim.cmd("highlight BufferCurrent guibg=" .. tabColor)
          vim.cmd("highlight BufferCurrentERROR guibg=" .. tabColor)
          vim.cmd("highlight BufferCurrentHINT guibg=" .. tabColor)
          vim.cmd("highlight BufferCurrentINFO guibg=" .. tabColor)
          vim.cmd("highlight BufferCurrentWARN guibg=" .. tabColor)
          vim.cmd("highlight BufferCurrentIndex guibg=" .. tabColor)
          vim.cmd("highlight BufferCurrentMod guibg=" .. tabColor)
          vim.cmd("highlight BufferCurrentSign guibg=" .. tabColor)
          vim.cmd("highlight BufferCurrentTarget guibg=" .. tabColor)
          vim.cmd("highlight BufferAlternate guibg=" .. tabColor)
          vim.cmd("highlight BufferAlternateERROR guibg=" .. tabColor)
          vim.cmd("highlight BufferAlternateHINT guibg=" .. tabColor)
          vim.cmd("highlight BufferTabpageFill guibg=" .. barColor)
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

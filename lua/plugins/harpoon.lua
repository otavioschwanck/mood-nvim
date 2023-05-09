local function shorten_filenames(filenames)
  local shortened = {}

  -- Count the occurrences of each filename
  local counts = {}
  for _, file in ipairs(filenames) do
    local name = vim.fn.fnamemodify(file.filename, ":t")
    counts[name] = (counts[name] or 0) + 1
  end

  -- Generate the shortened filenames
  for _, file in ipairs(filenames) do
    local name = vim.fn.fnamemodify(file.filename, ":t")

    if counts[name] == 1 then
      table.insert(shortened, { filename = vim.fn.fnamemodify(name, ":t") })
    else
      table.insert(shortened, { filename = file.filename })
    end
  end

  return shortened
end

return {
  {
    'ThePrimeagen/harpoon',
    opts = {},
    config = function()
      local function set_tabline()
        vim.o.tabline = '%!v:lua.tabline()'
      end

      function _G.tabline()
        local original_tabs = require('harpoon').get_mark_config().marks
        local tabs = shorten_filenames(original_tabs)
        local tabline = ''

        for i, tab in ipairs(original_tabs) do
          local is_current = string.match(vim.fn.bufname(), tab.filename)

          local label = tabs[i].filename

          if is_current then
            tabline = tabline .. '%#TabLineSel#'
          else
            tabline = tabline .. '%#TabLine#'
          end

          tabline = tabline .. '   ' .. i .. ':' .. label .. '   %*'
          if i < #tabs then
            tabline = tabline .. '%T'
          end
        end

        return tabline
      end

      vim.opt.showtabline = 2

      -- -- Set the highlight groups for the tabline
      vim.cmd('highlight! TabLine guibg=NONE guifg=#63698c')
      vim.cmd('highlight! TabLineSel guibg=NONE guifg=white')

      -- Set the tabline
      set_tabline()
    end,
    keys = {
      { ';',     '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = 'Harpoon menu' },
      { '<C-s>', '<cmd>lua require("harpoon.mark").toggle_file()<cr>',                                           desc = 'Pin on Harpoon' },
    }
  }
}

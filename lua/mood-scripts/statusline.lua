local function setup()
  vim.o.laststatus = vim.g.lualine_laststatus

  local theme = require("lualine.themes.catppuccin-mocha")
  local catppuccin_colors = require("catppuccin.palettes").get_palette()

  local open_terms = {
    require("tmux-awesome-manager.src.integrations.status").open_terms,
    color = { fg = catppuccin_colors.green },
  }

  local function arrow()
    local status = require("arrow.statusline").text_for_statusline_with_icons()

    return status
  end

  local arrow_module = {
    arrow,
    color = { fg = catppuccin_colors.pink },
  }

  local filename_with_icon = require('lualine.components.filename'):extend()
  filename_with_icon.apply_icon = require('lualine.components.filetype').apply_icon
  filename_with_icon.icon_hl_cache = {}


  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
  }

  local function count(base, pattern)
    return select(2, string.gsub(base, pattern, ''))
  end

  local function shorten_path(path, sep)
    -- ('([^/])[^/]+%/', '%1/', 1)
    return path:gsub(string.format('([^%s])[^%s]+%%%s', sep, sep, sep), '%1' .. sep, 1)
  end

  local function path()
    local dir = vim.fn.expand("%:p:h")

    if dir == vim.fn.getcwd() then
      return " Project Root"
    else
      local windwidth = vim.go.columns or vim.fn.winwidth(0)
      local estimated_space_available = windwidth - 30

      local data = vim.fn.fnamemodify(dir, ":~:.")
      for _ = 0, count(data, '/') do
        if windwidth <= 84 or #data > estimated_space_available then
          data = shorten_path(data, '/')
        end
      end

      return " " .. data
    end
  end


  require("lualine").setup({
    options = {
      disabled_filetypes = {
        statusline = { "dashboard" },
      },
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { filename_with_icon, color = { gui = 'bold' } }, { path, color = { fg = catppuccin_colors.pink } } },
      lualine_c = { arrow_module, "diagnostics", "diff" },
      lualine_x = { open_terms, "branch" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename', arrow },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {}
    },
  })
end

return setup

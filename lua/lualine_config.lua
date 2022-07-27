-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#fff',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local default_options = {
  symbols = { modified = '[+]', readonly = '[-]', unnamed = '[No Name]' },
  file_status = true,
  path = 0,
  shorting_target = 40,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

local options = vim.tbl_deep_extend('keep', {}, default_options)

local function has_space(space)
  local windwidth = options.globalstatus and vim.go.columns or vim.fn.winwidth(0)
  local estimated_space_available = windwidth - options.shorting_target

  return estimated_space_available > space
end

local function has_50_space()
  return has_space(50)
end

local function has_30_space()
  return has_space(30)
end

local function has_80_space()
  return has_space(80)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  'mode',
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.green,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  'filename',
  file_status = true,
  path = 0,
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

local function shorten_path(path, sep)
  -- ('([^/])[^/]+%/', '%1/', 1)
  return path:gsub(string.format('([^%s])[^%s]+%%%s', sep, sep, sep), '%1' .. sep, 1)
end

local function count(base, pattern)
  return select(2, string.gsub(base, pattern, ''))
end

ins_left {
  function()
    local dir = vim.fn.expand("%:p:h")

    if dir == vim.fn.getcwd() then
      return " Project Root"
    else
      local windwidth = options.globalstatus and vim.go.columns or vim.fn.winwidth(0)
      local estimated_space_available = windwidth - options.shorting_target

      local data = vim.fn.fnamemodify(dir, ":~:.")
      for _ = 0, count(data, '/') do
        if windwidth <= 84 or #data > estimated_space_available then
          data = shorten_path(data, '/')
        end
      end

      return " " .. data
    end
  end,
  cond = conditions.buffer_not_empty,
  color = { fg = colors.violet },
}

local function harpoon_cond()
  return has_30_space() and conditions.buffer_not_empty()
end

ins_left {
  function()
    local harpoon_number = require('harpoon.mark').get_index_of(vim.fn.bufname())
    if harpoon_number then
      return "ﯠ " .. harpoon_number
    else
      return "ﯡ "
    end
  end,
  color = function()
    if require('harpoon.mark').get_index_of(vim.fn.bufname()) then
      return { fg = colors.green, gui = 'bold' }
    else
      return { fg = colors.red }
    end
  end,
  cond = harpoon_cond,
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
  cond = has_30_space
}

ins_left {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = has_50_space,
}

ins_left {
  function()
    if vim.g.maximized then
      if(has_50_space) then
        return " Window Maximized"
      else
        return ""
      end
    end

    return ""
  end,
  color = { fg = colors.orange }
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

local default_servers = {
  {
    buffer_name = 'Rails Console',
    text = ' Console',
  },
  {
    buffer_name = 'Rails Server',
    text = ' Server',
  },
  {
    buffer_name = 'Yarn Dev',
    text = ' Yarn',
  },
  {
    buffer_name = 'Brownie Console',
    text = ' Brownie Console',
  },
  {
    buffer_name = 'Brownie Server',
    text = ' Brownie Server',
  },
}

local function is_server_running()
  local server_texts = {}
  local servers = vim.g.servers_on_lualine or default_servers

  local buffers = vim.api.nvim_list_bufs()

  for b_index, b in pairs(buffers) do
    local buf_name = vim.fn.bufname(b)

    for s_index, server in pairs(servers) do
      if string.find(buf_name, server.buffer_name) then
        table.insert(server_texts, server.text)
      end
    end
  end
  return table.concat(server_texts, "  ")
end

ins_right {
  is_server_running,
  color = { fg = colors.green },
  cond = has_50_space
}

local function filetype_cond()
  return conditions.buffer_not_empty() and has_80_space()
end

ins_right {
  'filetype',
  colored = true,
  icon_only = false,
  cond = filetype_cond,
  color = { fg = colors.blue, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
  cond = has_80_space
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)

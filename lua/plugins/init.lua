local plugins = {
  { 'folke/tokyonight.nvim', priority = 10000, config = function ()
    require("tokyonight").setup({
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          bg = prompt,
        }
        hl.TelescopePromptBorder = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    })
  end },
  { 'AndrewRadev/bufferize.vim', cmd = "Bufferize" },
  { 'otavioschwanck/tmux-awesome-manager.nvim' },
  'nyoom-engineering/oxocarbon.nvim',
  { "catppuccin/nvim", name = "catppuccin" },
  { 'stevearc/aerial.nvim', config = function() require('aerial').setup({}) end },
  { 'sainnhe/gruvbox-material' },
  { 'tomlion/vim-solidity' },
  { 'rgroli/other.nvim' },
  'tpope/vim-repeat',
  { 'olimorris/onedarkpro.nvim' },
  { 'ggandor/lightspeed.nvim', config = function()
    require('lightspeed').setup({ ignore_case = true, jump_to_unique_chars = { safety_timeout = nil } })
  end },
  'norcalli/nvim-colorizer.lua',
  { 'emmanueltouzery/agitator.nvim' },
  'dhruvasagar/vim-table-mode',
  { 'tpope/vim-commentary', keys = "gc" },
  'machakann/vim-highlightedyank',
  'tpope/vim-surround',
  { 'vim-test/vim-test', init = function ()
    vim.g['test#runner_commands'] = { 'RSpec' }
  end },
  'tpope/vim-eunuch',
  'alvan/vim-closetag',
  'tpope/vim-rails',
  'vim-ruby/vim-ruby',
  'farmergreg/vim-lastplace',
  'svermeulen/vim-yoink',
  'p00f/nvim-ts-rainbow',
  { 'psf/black', cmd = "Black" },
  'tpope/vim-fugitive',
  'AndrewRadev/undoquit.vim',
  'michaeljsmith/vim-indent-object',
  { 'mbbill/undotree', cmd = "UndotreeToggle" },
  'sk1418/HowMuch',
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  'shaunsingh/nord.nvim',
  'Olical/vim-enmasse',
  { 'rcarriga/nvim-notify' },
  { 'otavioschwanck/cool-substitute.nvim',
    config = function() require('cool-substitute').setup({ setup_keybindings = true }) end },
  "rafamadriz/friendly-snippets",
  { 'hrsh7th/cmp-calc' },
  { 'mattn/emmet-vim' },

  { "ray-x/lsp_signature.nvim" },

  'windwp/nvim-ts-autotag',
  { 'svermeulen/vim-subversive' },

  { 'beloglazov/vim-textobj-quotes', dependencies = { 'kana/vim-textobj-user', } },
  'EdenEast/nightfox.nvim',
  { 'kdheepak/lazygit.nvim', cmd = "LazyGit" },
  'nicwest/vim-camelsnek',
  'AndrewRadev/sideways.vim',
  'AndrewRadev/splitjoin.vim',
  'AndrewRadev/switch.vim',
  {
    'folke/which-key.nvim'
  },
  'editorconfig/editorconfig-vim',
  'tpope/vim-abolish',
  'terryma/vim-multiple-cursors',
  'tommcdo/vim-exchange',
  { 'ray-x/lsp_signature.nvim', opts = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  } },
  'ecomba/vim-ruby-refactoring',
  { "MunifTanjim/nui.nvim", lazy = true },
  'nvim-tree/nvim-web-devicons',
  { 'xolox/vim-notes', dependencies = { 'xolox/vim-misc', } },
  { 'lukas-reineke/indent-blankline.nvim', config = function()
    vim.g.indent_blankline_filetype_exclude = {
      "help",
      "dashboard",
      "NvimTree",
    }

    require("indent_blankline").setup {
      space_char_blankline = " ",
      show_current_context = true,
    }
  end },
  { 'moll/vim-bbye' },
  { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end,
    dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'prochri/telescope-all-recent.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
    config = function()
      require 'telescope-all-recent'.setup {
        pickers = {
          find_files = {
            disable = false,
            use_cwd = true,
            sorting = 'recent',
          }
        }
      }
    end
  },
}

local user_plugins = require("user.plugins")

for p = 1, table.getn(user_plugins) do
  table.insert(plugins, user_plugins[p])
end

return plugins

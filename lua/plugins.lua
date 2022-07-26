vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  local plugins = require("user-plugins")

  for p = 1, table.getn(plugins) do
    use(plugins[p])
  end
  use { 'stevearc/aerial.nvim' }
  use { 'sainnhe/gruvbox-material' }
  use { 'tomlion/vim-solidity' }
  use { 'rgroli/other.nvim' }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use { 'NTBBloodbath/rest.nvim' }
  use 'tpope/vim-repeat'
  use { 'olimorris/onedarkpro.nvim' }
  use { 'ggandor/lightspeed.nvim', commit = "005320ff9e128de8689c6e675fa64ed5963e2d1c" }
  use 'norcalli/nvim-colorizer.lua'
  use { 'emmanueltouzery/agitator.nvim' }
  use 'dhruvasagar/vim-table-mode'
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use 'machakann/vim-highlightedyank'
  use 'gbprod/yanky.nvim'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'vim-test/vim-test'
  use 'tpope/vim-eunuch'
  use 'alvan/vim-closetag'
  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'
  use 'farmergreg/vim-lastplace'
  use 'svermeulen/vim-yoink'
  use 'p00f/nvim-ts-rainbow'
  use 'sainnhe/sonokai'
  use 'ThePrimeagen/refactoring.nvim'
  use 'psf/black'
  use 'tpope/vim-fugitive'
  use 'AndrewRadev/undoquit.vim'
  use 'michaeljsmith/vim-indent-object'
  use 'vimlab/split-term.vim'
  use 'nvim-lualine/lualine.nvim'
  use 'mbbill/undotree'
  use 'sk1418/HowMuch'
  use 'romgrk/barbar.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'shaunsingh/nord.nvim'
  use 'Olical/vim-enmasse'
  use { 'rcarriga/nvim-notify' }
  use {
    "AckslD/nvim-neoclip.lua",
    }
  -- optional
  use {'junegunn/fzf', run = function()
  vim.fn['fzf#install']()
  end }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
  }

  -- Editing stuff
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use "rafamadriz/friendly-snippets"
  use { 'hrsh7th/cmp-calc' }
  use 'mattn/emmet-vim'

  use { "ray-x/lsp_signature.nvim" }
  use { 'onsails/lspkind.nvim' }

  use 'windwp/nvim-ts-autotag'
  use { 'svermeulen/vim-subversive' }

  use 'kana/vim-textobj-user'
  use 'beloglazov/vim-textobj-quotes'
  use 'EdenEast/nightfox.nvim'
  use 'kdheepak/lazygit.nvim'
  use 'nicwest/vim-camelsnek'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'AndrewRadev/sideways.vim'
  use 'AndrewRadev/splitjoin.vim'
  use 'AndrewRadev/switch.vim'
  use 'folke/which-key.nvim'
  use 'RRethy/nvim-treesitter-endwise'
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-abolish'
  use 'terryma/vim-multiple-cursors'
  use 'junegunn/vim-easy-align'
  use 'tami5/sqlite.lua'
  use 'mtikekar/nvim-send-to-term'
  use 'skywind3000/asyncrun.vim'
  use 'tommcdo/vim-exchange'
  use 'pechorin/any-jump.vim'
  use 'ecomba/vim-ruby-refactoring'
  use 'ton/vim-bufsurf'
  use 'xolox/vim-notes'
  use 'xolox/vim-misc'
  use 'glepnir/dashboard-nvim'
  use 'lukas-reineke/indent-blankline.nvim'

  use {
    "williamboman/nvim-lsp-installer",
    {
        "neovim/nvim-lspconfig"
    }
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use { 'hrsh7th/cmp-cmdline' }
  use { 'camspiers/lens.vim' }
  use { 'danilamihailov/beacon.nvim' }
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use { 'dyng/ctrlsf.vim' }
  use { 'moll/vim-bbye' }
  use { 'ThePrimeagen/harpoon' }

  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- within packer init {{{
  use {'SirVer/ultisnips',
      requires = {{'honza/vim-snippets', rtp = '.'}},
      config = function()
        vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
        vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
        vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
        vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
        vim.g.UltiSnipsRemoveSelectModeMappings = 0
      end
  }
  -- }}}

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
  }

  use {'nvim-telescope/telescope-ui-select.nvim' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)

require('gitsigns').setup()
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    indent_blankline_filetype_exclude = { "dashboard" }
}
require'lightspeed'.setup {
  ignore_case = true
}

require("yanky").setup({
  ring = {
    history_length = 50,
    storage = "shada",
    sync_with_numbered_registers = true,
  },
  preserve_cursor_position = {
    enabled = true,
  },
})

require("rest-nvim").setup()

vim.g.indent_blankline_filetype_exclude = {
  "help",
  "dashboard",
  "packer",
  "NvimTree",
}

require'nvim-web-devicons'.setup {
  override = {
    rb = {
      icon = "",
      color = "#ff8587",
      cterm_color = "65",
      name = "Ruby"
    }
  }
}

require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local onedarkpro = require("onedarkpro")

onedarkpro.setup({
  plugins = {
    polygot = false,
  },
  styles = {
    comments = "italic",
    keywords = "italic",
    virtual_text = "italic,underline",
  },
  options = {
    bold = true,
    italic = true,
    underline = true,
    undercurl = true,
    cursorline = true,
    -- transparency = true,
  },
  colors = {
    onedark = {
      vim = "#81b766", -- green
      brackets = "#abb2bf", -- fg / gray
      cursorline = "#2e323b",
      indentline = "#3c414d",

      ghost_text = "#555961",

      statusline_bg = "#2e323b", -- gray

      bufferline_text_focus = "#949aa2",

      telescope_prompt = "#2e323a",
      telescope_results = "#21252d",
    },
    onelight = {
      vim = "#029632", -- green
      brackets = "#e05661", -- red
      scrollbar = "#eeeeee",

      ghost_text = "#c3c3c3",

      statusline_bg = "#f0f0f0", -- gray

      telescope_prompt = "#f5f5f5",
      telescope_results = "#eeeeee",
    },
  },
  filetype_hlgroups = {
    lua = {
      Hlargs = { fg = "${red}", style = "italic" },
    },
    yaml = { TSField = { fg = "${red}" } },
    python = {
      TSFunction = { fg = "${blue}", style = "bold" },
    },
    ruby = {
      Hlargs = { fg = "${red}" },
      TSFunction = { fg = "${blue}", style = "bold" },
      TSInclude = { fg = "${blue}", style = "italic" },
      TSParameter = { fg = "${fg}", style = "italic" },
      TSSymbol = { fg = "${cyan}" },
    },
    scss = {
      TSFunction = { fg = "${cyan}" },
      TSProperty = { fg = "${orange}" },
      TSPunctDelimiter = { fg = "${orange}" },
      TSType = { fg = "${red}" },
    },
  },
  hlgroups = {
    -- Highlight brackets with a custom color
    TSPunctBracket = { fg = "${brackets}" },
    TSPunctSpecial = { fg = "${brackets}" },

    -- Aerial plugin
    AerialClassIcon = { fg = "${purple}" },
    AerialConstructorIcon = { fg = "${yellow}" },
    AerialEnumIcon = { fg = "${blue}" },
    AerialFunctionIcon = { fg = "${red}" },
    AerialInterfaceIcon = { fg = "${orange}" },
    AerialMethodIcon = { fg = "${green}" },
    AerialStructIcon = { fg = "${cyan}" },

    -- Alpha (dashboard) plugin
    AlphaHeader = {
      fg = (vim.o.background == "dark" and "${green}" or "${red}"),
    },
    AlphaButtonText = {
      fg = "${blue}",
      style = "bold",
    },
    AlphaButtonShortcut = {
      fg = (vim.o.background == "dark" and "${green}" or "${yellow}"),
      style = "italic,bold",
    },
    AlphaFooter = { fg = "${gray}", style = "italic" },

    -- Cmp
    GhostText = { fg = "${ghost_text}" },

    -- Fidget plugin
    FidgetTitle = { fg = "${purple}" },
    FidgetTask = { fg = "${gray}" },

    -- Luasnip
    LuaSnipChoiceNode = { fg = "${yellow}" },
    LuaSnipInsertNode = { fg = "${yellow}" },

    -- Nvim navic
    NavicIconsClass = { fg = "${purple}" },
    NavicIconsFunction = { fg = "${blue}" },
    NavicIconsVariable = { fg = "${red}" },
    NavicIconsConstant = { fg = "${orange}" },
    NavicIconsBoolean = { fg = "${orange}" },
    NavicIconsString = { fg = "${green}" },
    NavicIconsObject = { fg = "${purple}" },
    NavicIconsProperty = { fg = "${fg}" },
    NavicText = { fg = "${gray}", style = "italic" },
    NavicSeparator = { fg = "${gray}" },

    -- Minimap
    MapBase = { fg = "${gray}" },
    MapCursor = { fg = "${purple}", bg = "${cursorline}" },
    -- MapRange = { fg = "${fg}" },

    -- Telescope
    TelescopeBorder = {
      fg = "${telescope_results}",
      bg = "${telescope_results}",
    },
    TelescopePromptBorder = {
      fg = "${telescope_prompt}",
      bg = "${telescope_prompt}",
    },
    TelescopePromptCounter = { fg = "${fg}" },
    TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
    TelescopePromptPrefix = {
      fg = "${purple}",
      bg = "${telescope_prompt}",
    },
    TelescopePromptTitle = {
      fg = "${telescope_prompt}",
      bg = "${purple}",
    },

    TelescopePreviewTitle = {
      fg = "${telescope_results}",
      bg = "${green}",
    },
    TelescopeResultsTitle = {
      fg = "${telescope_results}",
      bg = "${telescope_results}",
    },

    TelescopeMatching = { fg = "${purple}" },
    TelescopeNormal = { bg = "${telescope_results}" },
    TelescopeSelection = { bg = "${telescope_prompt}" },
  },
})
require('aerial').setup({})
return packer


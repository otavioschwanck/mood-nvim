local M = {}

function M.setup()
  vim.cmd [[packadd packer.nvim]]

  require('packer').startup(function()
    local plugins = require("user.plugins")

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
    use 'psf/black'
    use 'tpope/vim-fugitive'
    use 'AndrewRadev/undoquit.vim'
    use 'michaeljsmith/vim-indent-object'
    use 'vimlab/split-term.vim'
    use 'nvim-lualine/lualine.nvim'
    use 'mbbill/undotree'
    use 'sk1418/HowMuch'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'shaunsingh/nord.nvim'
    use 'Olical/vim-enmasse'
    use { 'rcarriga/nvim-notify' }
    use {
      "AckslD/nvim-neoclip.lua",
    }

    use {'junegunn/fzf', run = function()
      vim.fn['fzf#install']()
    end }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
    }

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
    ignore_case = true,
    jump_to_unique_chars = { safety_timeout = 1300 },
  }

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

  require('aerial').setup({})
end

return M

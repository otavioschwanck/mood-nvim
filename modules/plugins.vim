lua << LUA
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  local plugins = require("user-plugins")

  for p = 1, table.getn(plugins) do
    use(plugins[p])
  end
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'tpope/vim-repeat'
  use { 'ggandor/lightspeed.nvim', commit = "005320ff9e128de8689c6e675fa64ed5963e2d1c" }
  use 'norcalli/nvim-colorizer.lua'
  use 'dhruvasagar/vim-table-mode'
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use 'machakann/vim-highlightedyank'
  use 'gbprod/yanky.nvim'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'NLKNguyen/papercolor-theme'
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
  use 'ahmedkhalf/project.nvim'
  use 'tpope/vim-fugitive'
  use 'AndrewRadev/undoquit.vim'
  use 'michaeljsmith/vim-indent-object'
  use 'vimlab/split-term.vim'
  use 'nvim-lualine/lualine.nvim'
  use 'mbbill/undotree'
  use 'sk1418/HowMuch'
  use 'romgrk/barbar.nvim'
  use 'LunarVim/onedarker.nvim'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'projekt0n/github-nvim-theme'
  use {'kevinhwang91/nvim-bqf'}
  use 'shaunsingh/nord.nvim'

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
  use 'nvim-telescope/telescope-project.nvim'
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
  use 'ellisonleao/gruvbox.nvim'
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
        "neovim/nvim-lspconfig",
        config = function()
        require("nvim-lsp-installer").setup {
          automatic_installation = true,
        }
        end
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
  use { 'mg979/vim-visual-multi' }

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
LUA

lua <<END

require('lualine').setup {
  extensions = { "quickfix", "nvim-tree", "toggleterm" }
}
require('gitsigns').setup()
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    indent_blankline_filetype_exclude = { "dashboard" }
}
require'lightspeed'.setup {
  ignore_case = true
}

require("project_nvim").setup { }

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

vim.g.indent_blankline_filetype_exclude = {
  "help",
  "dashboard",
  "packer",
  "NvimTree",
}
END

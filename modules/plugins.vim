lua <<LUA

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  local plugins = require("user-plugins")

  for p = 1, table.getn(plugins) do
    use(plugins[p])
  end
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'tpope/vim-repeat'
  use { 'ggandor/lightspeed.nvim', commit = "005320ff9e128de8689c6e675fa64ed5963e2d1c" }
  use 'dhruvasagar/vim-table-mode'
  use 'catppuccin/nvim'
  use 'folke/tokyonight.nvim'
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use 'machakann/vim-highlightedyank'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'
  use 'vim-test/vim-test'
  use 'tpope/vim-eunuch'
  use 'alvan/vim-closetag'
  use 'tpope/vim-rails'
  use 'vim-ruby/vim-ruby'
  use 'jeetsukumaran/vim-indentwise'
  use 'akinsho/toggleterm.nvim'
  use 'farmergreg/vim-lastplace'
  use 'ThePrimeagen/harpoon'
  use 'svermeulen/vim-yoink'
  use 'p00f/nvim-ts-rainbow'
  use 'sainnhe/sonokai'
  use 'sainnhe/everforest'
  use 't9md/vim-choosewin'
  use 'ThePrimeagen/refactoring.nvim'
  use 'psf/black'
  use 'tpope/vim-fugitive'
  use 'AndrewRadev/undoquit.vim'
  use 'pseewald/vim-anyfold'
  use 'michaeljsmith/vim-indent-object'
  use 'norcalli/nvim-terminal.lua'
  use 'camgraff/telescope-tmux.nvim'
  use 'vimlab/split-term.vim'
  use 'nvim-lualine/lualine.nvim'
  use 'mbbill/undotree'
  use { "ahmedkhalf/project.nvim" }
  use 'sk1418/HowMuch'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
  }

  -- Editing stuff
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'tmux-plugins/vim-tmux-focus-events'
  use {'neoclide/coc.nvim', branch = 'release'}
  use "rafamadriz/friendly-snippets"

  use 'windwp/nvim-ts-autotag'
  use { 'svermeulen/vim-subversive' }
  use { 'phaazon/hop.nvim' }

  use 'kana/vim-textobj-user'
  use 'beloglazov/vim-textobj-quotes'
  use 'EdenEast/nightfox.nvim'
  use 'cocopon/iceberg.vim'
  use 'kdheepak/lazygit.nvim'
  use 'NLKNguyen/papercolor-theme'
  use 'nicwest/vim-camelsnek'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'AndrewRadev/sideways.vim'
  use 'AndrewRadev/splitjoin.vim'
  use 'AndrewRadev/switch.vim'
  use 'folke/which-key.nvim'
  use 'RRethy/nvim-treesitter-endwise'
  use 'editorconfig/editorconfig-vim'
  use 'preservim/tagbar'
  use 'tpope/vim-abolish'
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use 'terryma/vim-multiple-cursors'
  use 'junegunn/vim-easy-align'
  use 'tami5/sqlite.lua'
  use 'ellisonleao/gruvbox.nvim'
  use 'fannheyward/telescope-coc.nvim'
  use 'tanvirtin/monokai.nvim'
  use 'D1mon/molokai'
  use 'skywind3000/asyncrun.vim'
  use 'bluz71/vim-moonfly-colors'
  use 'tommcdo/vim-exchange'
  use 'pechorin/any-jump.vim'
  use 'navarasu/onedark.nvim'
  use 'ecomba/vim-ruby-refactoring'
  use 'ton/vim-bufsurf'
  use 'xolox/vim-notes'
  use 'xolox/vim-misc'
  use 'glepnir/dashboard-nvim'
  use 'lukas-reineke/indent-blankline.nvim'

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },

  }

  use 'tomlion/vim-solidity'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)
LUA

lua <<END

require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
require('lualine').setup {
  extensions = { "quickfix", "nvim-tree", "toggleterm" }
}
require('gitsigns').setup()
require("project_nvim").setup {}
require('nvim-tree').setup {}
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    indent_blankline_filetype_exclude = { "dashboard" }
}
require'lightspeed'.setup {
  ignore_case = true
}

vim.g.indent_blankline_filetype_exclude = {
  "help",
  "dashboard",
  "packer",
  "NvimTree",
}
END

lua require'terminal'.setup()

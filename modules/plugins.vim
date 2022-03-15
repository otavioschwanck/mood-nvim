lua <<LUA

return require('packer').startup(function()
  use 'dhruvasagar/vim-table-mode'
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
  use 'ThePrimeagen/refactoring.nvim'
  use 'psf/black'
  use 'tpope/vim-fugitive'
  use 'AndrewRadev/undoquit.vim'
  use 'rhysd/clever-f.vim'
  use 'pseewald/vim-anyfold'
  use 'michaeljsmith/vim-indent-object'
  use 'norcalli/nvim-terminal.lua'
  use 'camgraff/telescope-tmux.nvim'
  use 'vimlab/split-term.vim'
  use 'nvim-lualine/lualine.nvim'
  use 'mbbill/undotree'
  use {
    "ahmedkhalf/project.nvim",
    config = function()
    require("project_nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      }
  end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
    config = function() require'nvim-tree'.setup {} end
  }

  -- Editing stuff
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'tmux-plugins/vim-tmux-focus-events'
  use {'neoclide/coc.nvim', branch = 'release'}
  use "rafamadriz/friendly-snippets"
  use 'windwp/nvim-ts-autotag'
  use { 'svermeulen/vim-subversive' }
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use 'wellle/targets.vim'

  use 'EdenEast/nightfox.nvim'
  use 'cocopon/iceberg.vim'
  use 'kdheepak/lazygit.nvim'
  use 'NLKNguyen/papercolor-theme'
  use 'nicwest/vim-camelsnek'
  use 'AndrewRadev/sideways.vim'
  use 'AndrewRadev/splitjoin.vim'
  use 'AndrewRadev/switch.vim'
  use 'folke/which-key.nvim'
  use 'RRethy/nvim-treesitter-endwise'
  use 'editorconfig/editorconfig-vim'
  use 'rcarriga/vim-ultest'
  use 'preservim/tagbar'
  use 'tpope/vim-abolish'
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
  use 'terryma/vim-multiple-cursors'
  use 'nvim-telescope/telescope-frecency.nvim'
  use 'tami5/sqlite.lua'
  use 'ellisonleao/gruvbox.nvim'
  use 'mildred/vim-bufmru'
  use 'fannheyward/telescope-coc.nvim'
  use 'tomasr/molokai'

  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use 'tomlion/vim-solidity'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)
LUA

lua <<END
require('lualine').setup({
  options = { theme = 'gruvbox' }
})
require('telescope').load_extension('projects')
END

lua require'terminal'.setup()
let g:coc_global_extensions = ['coc-html', 'coc-css', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-solidity',
      \ 'coc-solargraph', 'coc-emmet', 'coc-yaml', 'coc-snippets', 'coc-pyright', 'coc-solidity']

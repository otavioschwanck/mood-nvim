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
  use "rafamadriz/friendly-snippets"
  use 'windwp/nvim-ts-autotag'
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
  use 'tomasr/molokai'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use { 'williamboman/nvim-lsp-installer' }
  use { 'jose-elias-alvarez/null-ls.nvim' }

  use 'quangnguyen30192/cmp-nvim-ultisnips'
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

  use { 'ray-x/lsp_signature.nvim' }
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

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, require("null-ls").builtins.diagnostics.rubocop._opts.args),
        }),
    }
})


END

lua require'terminal'.setup()

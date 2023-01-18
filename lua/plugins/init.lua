local plugins = {
  { 'AndrewRadev/bufferize.vim', cmd = "Bufferize" },
  { 'otavioschwanck/tmux-awesome-manager.nvim' },
   'nyoom-engineering/oxocarbon.nvim',
   { 'andersevenrud/cmp-tmux', dependencies = { 'hrsh7th/nvim-cmp' } },
  { "rebelot/kanagawa.nvim" },
   { "catppuccin/nvim", name = "catppuccin" },
   { 'stevearc/aerial.nvim', config = function() require('aerial').setup({}) end },
   { 'sainnhe/gruvbox-material' },
   { 'tomlion/vim-solidity' },
   { 'rgroli/other.nvim' },
   'tpope/vim-repeat',
   { 'olimorris/onedarkpro.nvim' },
   { 'ggandor/lightspeed.nvim', config = function()
     require('lightspeed').setup({ ignore_case = true, jump_to_unique_chars = { safety_timeout = nil } })
   end},
   'norcalli/nvim-colorizer.lua',
   { 'emmanueltouzery/agitator.nvim' },
   'dhruvasagar/vim-table-mode',
   'tpope/vim-commentary',
  'machakann/vim-highlightedyank',
  'tpope/vim-surround',
  'vim-test/vim-test',
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
  'mbbill/undotree',
  'sk1418/HowMuch',
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
  'shaunsingh/nord.nvim',
  'Olical/vim-enmasse',
  { 'rcarriga/nvim-notify' },
  { "AckslD/nvim-neoclip.lua" },
   { 'otavioschwanck/cool-substitute.nvim', config = function() require('cool-substitute').setup({ setup_keybindings = true }) end },
  "rafamadriz/friendly-snippets",
  { 'hrsh7th/cmp-calc' },
  'mattn/emmet-vim',

  { "ray-x/lsp_signature.nvim" },
  { 'onsails/lspkind.nvim' },

  'windwp/nvim-ts-autotag',
  { 'svermeulen/vim-subversive' },
  { 'prettier/vim-prettier', build = "yarn install --frozen-lockfile --production" },

  { 'beloglazov/vim-textobj-quotes', dependencies = { 'kana/vim-textobj-user', } },
  'EdenEast/nightfox.nvim',
  { 'kdheepak/lazygit.nvim', cmd = "LazyGit" },
  'nicwest/vim-camelsnek',
  'AndrewRadev/sideways.vim',
  'AndrewRadev/splitjoin.vim',
  'AndrewRadev/switch.vim',
	{
		'folke/which-key.nvim',
		config = function()
			require('core.mappings').setup()
			pcall(require, 'user.keybindings')
		end,
	},
  'editorconfig/editorconfig-vim',
  'tpope/vim-abolish',
  'terryma/vim-multiple-cursors',
  'junegunn/vim-easy-align',
  'tami5/sqlite.lua',
  'mtikekar/nvim-send-to-term',
  'skywind3000/asyncrun.vim',
  'tommcdo/vim-exchange',
  'pechorin/any-jump.vim',
  'ecomba/vim-ruby-refactoring',
  'ton/vim-bufsurf',
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
      show_current_context_start = true,
    }
  end },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  { 'hrsh7th/cmp-cmdline' },
  { 'danilamihailov/beacon.nvim' },
  'hrsh7th/cmp-path',
  'hrsh7th/nvim-cmp',
  { 'moll/vim-bbye' },
  { 'ThePrimeagen/harpoon' },
  'quangnguyen30192/cmp-nvim-ultisnips',
  { 'SirVer/ultisnips',
    dependencies = { { 'honza/vim-snippets', config = function() vim.opt.rtp:append('.') end, } }, config = function()
      vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
      vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
      vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
      vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
    end
  },
  { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end, dependencies = { 'nvim-lua/plenary.nvim' } },
}

local user_plugins = require("user.plugins")

for p = 1, table.getn(user_plugins) do
  table.insert(plugins, user_plugins[p])
end

return plugins

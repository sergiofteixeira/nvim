if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

if has("nvim")
  Plug 'hoob3rt/lualine.nvim'
  Plug 'neovim/nvim-lspconfig', { 'branch': 'master' }
  Plug 'tami5/lspsaga.nvim',
  Plug 'folke/lsp-colors.nvim'
  Plug 'onsails/lspkind-nvim'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'ThePrimeagen/harpoon'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'hashivim/vim-terraform'
  Plug 'juliosueiras/vim-terraform-completion'
  Plug 'preservim/nerdcommenter'
  Plug 'ryanoasis/vim-devicons'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'SmiteshP/nvim-gps'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
  Plug 'towolf/vim-helm'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-telescope/telescope-file-browser.nvim'
  Plug 'pappasam/papercolor-theme-slim'
  Plug 'mcchrish/zenbones.nvim'
  Plug 'rktjmp/lush.nvim'
endif

call plug#end()

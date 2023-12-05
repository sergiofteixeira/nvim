vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippet
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")
    use('rktjmp/lush.nvim')
    use('lewis6991/gitsigns.nvim')
    use('hoob3rt/lualine.nvim')
    use('windwp/nvim-autopairs')
    use('kyazdani42/nvim-tree.lua')
    use('kyazdani42/nvim-web-devicons')
    use {
        'akinsho/bufferline.nvim', tag = 'v3.*',
    }
    use('preservim/nerdcommenter')
    use("SmiteshP/nvim-navic")
    use('rose-pine/neovim')
    use { 'prevostcorentin/null-ls.nvim', branch = 'format-hcl-nomad' }
    use { "ellisonleao/gruvbox.nvim" }
    use ({ 'projekt0n/github-nvim-theme' })
    use ('shaunsingh/solarized.nvim')

end)

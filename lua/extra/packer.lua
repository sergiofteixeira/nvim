vim.cmd.packadd('packer.nvim')
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } } }

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')

    use {
        'neovim/nvim-lspconfig',
        requires = {
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            { 'rafamadriz/friendly-snippets' },
        }
    }

    use({
        "L3MON4D3/LuaSnip",
        tag = "v2.3.0",
        run = "make install_jsregexp"
    })
    use('lewis6991/gitsigns.nvim')
    use('hoob3rt/lualine.nvim')
    use('windwp/nvim-autopairs')
    use('kyazdani42/nvim-web-devicons')
    use {
        'akinsho/bufferline.nvim',
    }
    use('preservim/nerdcommenter')
    use("SmiteshP/nvim-navic")
    use('onsails/lspkind.nvim')
    use("folke/todo-comments.nvim")
    use {
        "someone-stole-my-name/yaml-companion.nvim",
        config = function()
            require("telescope").load_extension("yaml_schema")
        end,
    }
    use "b0o/schemastore.nvim"
    use "stevearc/conform.nvim"
    use 'folke/trouble.nvim'
    use { 'oneslash/helix-nvim', tag = "*" }
    use {
        'nvim-neo-tree/neo-tree.nvim',
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        }
    }
    use {
        'NeogitOrg/neogit',
        requires = {
            { 'ibhagwan/fzf-lua',
                'sindrets/diffview.nvim'
            }

        }
    }
    use 'nvimdev/dashboard-nvim'
    use({
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons",       -- keep this if you're using NvChad
        config = function()
            require("barbecue").setup()
        end,
    })
    use 'rose-pine/neovim'
end)

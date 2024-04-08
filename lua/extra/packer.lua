vim.cmd.packadd('packer.nvim')
-- NOTE Use lazy nvim
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
    use('onsails/lspkind.nvim')
    use('folke/tokyonight.nvim')
    use("folke/todo-comments.nvim")
    use("ellisonleao/gruvbox.nvim")
    use {
        'VonHeikemen/fine-cmdline.nvim',
        requires = {
            { 'MunifTanjim/nui.nvim' }
        }
    }
    use {
        "someone-stole-my-name/yaml-companion.nvim",
        config = function()
            require("telescope").load_extension("yaml_schema")
        end,
    }
    use "b0o/schemastore.nvim"
    use "stevearc/conform.nvim"
    use 'Mofiqul/vscode.nvim'
    use {
        'NeogitOrg/neogit',
        requires = {
            { 'ibhagwan/fzf-lua',
                'sindrets/diffview.nvim'
            }

        }
    }
end)

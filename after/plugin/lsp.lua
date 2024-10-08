local lspconf = require("lspconfig")
local map = vim.api.nvim_set_keymap
local cmp = require('cmp')
local lspkind = require 'lspkind'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local navic = require("nvim-navic")
local on_attach = function(client, bufnr)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {})
    client.server_capabilities.semanticTokensProvider = nil
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

require('luasnip.loaders.from_vscode').lazy_load()
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'ts_ls',
        'nil_ls',
        'eslint',
        'pyright',
        'tflint',
        'terraformls',
        'lua_ls',
        'gopls',
        'clangd',
    },
})


-- Javascript/Typescript
lspconf.ts_ls.setup {
    on_attach = on_attach,
}

-- Lua
lspconf.lua_ls.setup {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT'
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
}

-- Golang
lspconf.gopls.setup {
    on_attach = on_attach,
    settings = {
        gopls = {
            gofumpt = true
        }
    }
}

-- Python
lspconf.ruff_lsp.setup {
    init_options = {
        settings = {
            args = {},
        }
    }
}

lspconf.pyright.setup {}


-- Nix
lspconf.nil_ls.setup {
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixfmt" },
            },
        },
    },
}

-- Clang
lspconf.clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
    init_options = {
        clangdFileStatus = true,
    },
    filetypes = {
        "c",
    },
}

cmp.setup({
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function(entry, vim_item)
                return vim_item
            end
        }),
    },
    sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    }),
})

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

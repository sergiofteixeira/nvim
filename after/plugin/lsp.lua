local map = vim.api.nvim_set_keymap
local lsp = require("lsp-zero")
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require 'lspkind'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local lspconf = require("lspconfig")

local on_attach = function(client)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {})
    client.server_capabilities.semanticTokensProvider = nil
end

local cfg = require("yaml-companion").setup {
    builtin_matchers = {
        kubernetes = { enabled = true }
    },

    schemas = {
        {
            name = "Argo CD Application",
            uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"
        },
        {
            name = "Kustomization",
            uri = "https://json.schemastore.org/kustomization.json"
        },
        {
            name = "GitHub Workflow",
            uri = "https://json.schemastore.org/github-workflow.json"
        },
    },

    lspconfig = {
        settings = {
            yaml = {
                validate = true,
                schemaStore = {
                    enable = false,
                    url = ""
                },

                -- schemas from store, matched by filename
                -- loaded automatically
                schemas = require('schemastore').yaml.schemas {
                    select = {
                        'kustomization.yaml',
                        'GitHub Workflow',
                    }
                }
            }
        }
    }
}

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
    handlers = {
        lsp.default_setup,
    }
})

lspconf.tsserver.setup {
    on_attach = on_attach,
}
lspconf.gopls.setup {
    settings = {
        gopls = {
            gofumpt = true
        }
    }
}
lspconf.ruff_lsp.setup {
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

lspconf.dagger.setup {}

lspconf.yamlls.setup { cfg }

lspconf.nil_ls.setup {
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixfmt" },
            },
        },
    },
}

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
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
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

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local navic = require('nvim-navic')

    --if client.name == "eslint" then
    --vim.cmd.LspStop('eslint')
    --return
    --end

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

lsp.setup()

local function detach_yamlls()
    local clients = vim.lsp.get_active_clients()
    for client_id, client in pairs(clients) do
        if client.name == "yamlls" then
            vim.lsp.buf_detach_client(0, client_id)
        end
    end
end

local gotmpl_group = vim.api.nvim_create_augroup("_gotmpl", { clear = true })

-- detach yamlls from helm files
vim.api.nvim_create_autocmd("FileType", {
    group = gotmpl_group,
    pattern = "yaml",
    callback = function()
        vim.schedule(function()
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            for _, line in ipairs(lines) do
                if string.match(line, "{{.+}}") then
                    vim.defer_fn(detach_yamlls, 500)
                    return
                end
            end
        end)
    end,
})

vim.diagnostic.config({
    virtual_text = true,
})

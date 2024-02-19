local lsp = require("lsp-zero")
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local lspkind = require 'lspkind'
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local lspconf = require("lspconfig")

require('luasnip.loaders.from_vscode').lazy_load()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'tsserver',
        'nil_ls',
        'rnix',
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

lspconf.ruff_lsp.setup {
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}

lspconf.dagger.setup {}

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
            preset = 'codicons',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function(entry, vim_item)
                return vim_item
            end
        }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
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

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end

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

vim.diagnostic.config({
    virtual_text = true,
})

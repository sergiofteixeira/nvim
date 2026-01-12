return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'rafamadriz/friendly-snippets',
    'SmiteshP/nvim-navic',
    'onsails/lspkind.nvim',
    'L3MON4D3/LuaSnip'
  },
  config = function()
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

    local esLintCustomizations = {
      { rule = 'style/*',   severity = 'off', fixable = true },
      { rule = 'format/*',  severity = 'off', fixable = true },
      { rule = '*-indent',  severity = 'off', fixable = true },
      { rule = '*-spacing', severity = 'off', fixable = true },
      { rule = '*-spaces',  severity = 'off', fixable = true },
      { rule = '*-order',   severity = 'off', fixable = true },
      { rule = '*-dangle',  severity = 'off', fixable = true },
      { rule = '*-newline', severity = 'off', fixable = true },
      { rule = '*quotes',   severity = 'off', fixable = true },
      { rule = '*semi',     severity = 'off', fixable = true },
    }

    require('luasnip.loaders.from_vscode').lazy_load()
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        'tsgo',
        'denols',
        'zls',
        'rust_analyzer',
        'eslint',
        'tofu_ls',
        'pyright',
        'tflint',
        'lua_ls',
        'gopls',
        'clangd',
      },
    })

    vim.lsp.config('rust_analyzer', {})
    vim.lsp.config('tofuls', {})
    vim.lsp.config('tflint', {})
    -- Javascript/Typescript
    vim.lsp.enable('tsgo')

    -- Lua
    vim.lsp.config('lua_ls', {
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
    })

    -- Golang
    vim.lsp.config('gopls', {
      on_attach = on_attach,
      settings = {
        gopls = {
          gofumpt = true
        }
      }
    })

    -- Python
    vim.lsp.config('ruff', {
      init_options = {
        settings = {
          args = {},
        }
      }
    })

    vim.lsp.config('pyright', {})

    vim.lsp.config('eslint',
      {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
          "html",
          "markdown",
          "json",
          "jsonc",
          "toml",
          "xml",
          "gql",
          "graphql",
          "astro",
          "svelte",
          "css",
          "less",
          "scss",
          "pcss",
          "postcss"
        },
        settings = {
          rulesCustomizations = esLintCustomizations,
        },
      }
    )


    -- Nix
    vim.lsp.config('nil_ls', {
      settings = {
        ['nil'] = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    })


    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*.tf", "*.tfvars" },
      callback = function()
        vim.lsp.buf.format()
      end,
    })
    vim.lsp.config('zls', {})

    -- Clang
    vim.lsp.config('clangd', {
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
    })

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
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename variable' })
  end,
  vim.lsp.set_log_level("off")
}

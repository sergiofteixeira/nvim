return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'rafamadriz/friendly-snippets',
    'SmiteshP/nvim-navic',
    'onsails/lspkind.nvim',
    'saghen/blink.cmp',
    'L3MON4D3/LuaSnip'
  },
  config = function()
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    local lspconf = require("lspconfig")
    local map = vim.api.nvim_set_keymap
    local lspkind = require 'lspkind'
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
        'zls',
        'rust_analyzer',
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

    lspconf.rust_analyzer.setup {}
    -- Javascript/Typescript
    lspconf.ts_ls.setup {
      --on_attach = on_attach,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
      settings = {
        typescript = {
          format = {
            tabSize = 2,
            insertSpaces = true
          }
        },
        javascript = {
          format = {
            tabSize = 2,
            insertSpaces = true
          }
        }
      }
    }

    -- Lua
    lspconf.lua_ls.setup {
      capabilities = capabilities,
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
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        gopls = {
          gofumpt = true
        }
      }
    }

    -- Python
    lspconf.ruff.setup {
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

    lspconf.terraformls.setup {
    }
    lspconf.zls.setup {}

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
  end,
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'someone-stole-my-name/yaml-companion.nvim',
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

    local yamlConfig = require("yaml-companion").setup {
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
        'zls',
        'yamlls',
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

    lspconf.yamlls.setup { yamlConfig }
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
  end,
}

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
        'denols',
        'zls',
        'yamlls',
        'rust_analyzer',
        'eslint',
        'tofuls',
        'pyright',
        'tflint',
        'lua_ls',
        'gopls',
        'clangd',
      },
    })

    vim.lsp.config('yamlls', yamlConfig)
    vim.lsp.config('rust_analyzer', {})
    vim.lsp.config('tofuls', {})
    vim.lsp.config('tflint', {})
    -- Javascript/Typescript
    vim.lsp.config('denols', {
      root_dir = require("lspconfig.util").root_pattern('deno.json', 'deno.jsonc'),
      -- attaches only if these files exist
    })
    vim.lsp.config('ts_ls', {
      --on_attach = on_attach,
      root_dir = function(fname)
        -- This will use tsserver unless a deno config is present
        local util = require("lspconfig.util")
        return not util.root_pattern('deno.json', 'deno.jsonc')(fname)
            and util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git')(fname)
      end,
      single_file_support = false,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
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
    })

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
          "yaml",
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

    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename variable' })
  end,
  vim.lsp.set_log_level("off")
}

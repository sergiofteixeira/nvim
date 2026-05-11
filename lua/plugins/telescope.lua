return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local telescope = require("telescope")
    local multi_ripgrep = require("plugins.telescope.multigrep")

    telescope.setup({
      defaults = {
        wrap_results = true,
        -- Include hidden files/dirs (e.g. .github) in grep-based pickers.
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/*",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob=!.git/*" }
          end,
        },
        diagnostics = {
          previewer = false,
        },
      },
    })

    vim.keymap.set("n", "<space>fg", multi_ripgrep)
  end
}

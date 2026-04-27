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
      },
      pickers = {
        diagnostics = {
          previewer = false,
        },
      },
    })

    vim.keymap.set("n", "<space>fg", multi_ripgrep)
  end
}

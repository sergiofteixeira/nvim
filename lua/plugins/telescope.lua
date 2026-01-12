return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local scope = require("telescope")
    local multi_ripgrep = require("plugins.telescope.multigrep")
    vim.keymap.set("n", "<space>fg", multi_ripgrep)
  end
}

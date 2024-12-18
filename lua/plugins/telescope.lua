return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'someone-stole-my-name/yaml-companion.nvim'
  },
  config = function()
    require("telescope").load_extension("yaml_schema")
    local scope = require("telescope")
    scope.load_extension("yaml_schema")
    local multi_ripgrep = require("plugins.telescope.multigrep")
    vim.keymap.set("n", "<space>fg", multi_ripgrep)
  end
}

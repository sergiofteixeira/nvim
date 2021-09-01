if !exists('g:loaded_telescope') | finish | endif

nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>/ <cmd>Telescope live_grep<cr>

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF


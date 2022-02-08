if !exists('g:loaded_telescope') | finish | endif

nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <Leader>pp <cmd>lua require'telescope.builtin'.git_commits{}<CR>
nnoremap <Leader>gs <cmd>lua require'telescope.builtin'.git_status{}<CR>

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require("telescope").load_extension('harpoon')
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


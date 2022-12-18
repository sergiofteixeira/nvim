if !exists('g:loaded_telescope') | finish | endif

nnoremap <leader>f <cmd>Telescope find_files({ winblend = 10 })<cr>
nnoremap <leader>/ <cmd>Telescope live_grep<cr>
nnoremap <Leader>pp <cmd>lua require'telescope.builtin'.git_commits{}<CR>
nnoremap <Leader>gs <cmd>lua require'telescope.builtin'.git_status{}<CR>

lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require("telescope").load_extension('harpoon')
require("telescope").load_extension "file_browser"
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    }
    }
}
EOF

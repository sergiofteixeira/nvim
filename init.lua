require("extra")
vim.cmd [[colorscheme carbonfox]]

vim.cmd([[
augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END
]])

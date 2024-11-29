vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- nvim-tree binds

-- nvim-ale config
vim.cmd [[
  let g:ale_linters = {
      \ 'typescript': ['tsserver'],
      \ 'typescriptreact': ['tsserver'],
      \ }
  let g:ale_fixers = {
      \ 'typescript': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ }
  let g:ale_fix_on_save = 1
]]

-- telescope binds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<C-f>', builtin.find_files, {})

-- generic remaps
vim.keymap.set("n", "<leader>q", "<cmd>:q<CR>")
vim.keymap.set("n", "<leader>s", "<cmd>:w<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>:!kubectl apply -f %<CR>zz")
vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.setqflist()<CR>", { silent = true })

-- neotree
vim.keymap.set("n", "<leader>e", ":Neotree toggle float<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", ":Neotree toggle left<CR>", { silent = true })
vim.keymap.set("n", "<leader>z", vim.lsp.buf.format)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

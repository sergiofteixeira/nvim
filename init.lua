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

vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
vim.cmd([[autocmd BufRead,BufNewFile *.hujson set filetype=json]])
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.opt.wrap = true

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
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>:!kubectl apply -f %<CR>zz")
vim.keymap.set("n", "<leader>d", ":Telescope diagnostics<CR>", { silent = true })
vim.keymap.set("n", "<leader>g", ":Telescope git_status<CR>", { silent = true })
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { silent = true })
vim.keymap.set("n", "<leader>g", ":Telescope git_status<CR>", { silent = true })

-- neotree
vim.keymap.set("n", "<leader>e", ":Neotree toggle float<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", ":Neotree toggle left<CR>", { silent = true })
vim.keymap.set("n", "<leader>z", vim.lsp.buf.format)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

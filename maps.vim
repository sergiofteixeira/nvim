" Description: Keymaps
nnoremap <Space> <Nop>
let mapleader = " "

" Select all
nmap <C-a> gg<S-v>G

" Open current directory
map <leader>q :q<CR>
map <leader>s :w<CR>
vmap <C-c> "+y<Esc>
nmap <leader>r :!node %<CR>
nmap <leader>k :!kubectl apply -f %<CR>
nmap <leader>h :lua require("harpoon.ui").toggle_quick_menu()<CR>
nmap <leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nmap <leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nmap <leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nmap <leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
nmap <leader>m :lua require("harpoon.mark").add_file()<CR>
nmap <leader>g :g<CR>
nnoremap <leader>t :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

"------------------------------
" Windows

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

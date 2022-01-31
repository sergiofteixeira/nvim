" Description: Keymaps
nnoremap <Space> <Nop>
let mapleader = " "

" Select all
nmap <C-a> gg<S-v>G

" Open current directory
map <leader>q :q<CR>
map <leader>s :w<CR>
vmap <C-c> "+y<Esc>
nmap <leader>t :NERDTreeToggle<CR>
nmap <leader>r :!node %<CR>
nmap <leader>k :!kubectl apply -f %<CR>

"------------------------------
" Windows

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

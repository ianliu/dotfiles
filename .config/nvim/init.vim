call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
call plug#end()

"   _   ,_,   _
"  / `'=) (='` \
" /.-.-.\ /.-.-.\ 
" `      "      `
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [[ 'mode', 'paste'],
      \            [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Leader of the pack!!!
let mapleader = " "
nnoremap <Leader><Space> :Files<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bk <C-^>:bw #<CR>
nnoremap <Leader>s :Rg<Space>

" Auto-closing brackets
inoremap {<CR> {<CR>}<Esc>O

" Better terminal escape
tnoremap <Esc> <C-\><C-n>

" Better cmdline movement
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

set hidden
set noshowmode

lua << EOF
require'lspconfig'.denols.setup{}
EOF

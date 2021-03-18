call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'neovim/nvim-lspconfig'
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'kassio/neoterm'
Plug 'hrsh7th/nvim-compe'
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

" Highlight lua heredocs in .vim files
let g:vimsyn_embed = 'lPr'

" Open terminal at the bottom
let g:neoterm_default_mod = 'botright'
let g:neoterm_autoinsert = 1

" Leader of the pack!!!
let mapleader = " "
nnoremap <Leader><Space> :Files<CR>
nnoremap <Leader>bb :Buffers<CR>
nnoremap <Leader>bk <C-^>:bw #<CR>
nnoremap <Leader>s :Rg<Space>
nnoremap <Leader>t :Ttoggle resize=10<CR>
nnoremap <Leader>n :set nu! rnu!<CR>

" Auto-closing brackets
inoremap {<CR> {<CR>}<Esc>O

" Better terminal mappings
tnoremap <Esc> <cmd>Ttoggle<CR>
tnoremap <C-w><C-w> <cmd>wincmd p<cr>

" Better cmdline movement
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Compe
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" LSP mappings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>

set hidden
set noshowmode
set completeopt=menuone,noselect
set signcolumn=yes

lua << EOF
local lsp = require('lspconfig')
lsp.denols.setup{}
lsp.pyright.setup{}

require('compe').setup({
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
    };
})
EOF

call plug#begin()
Plug 'pmsorhaindo/syntastic-local-eslint.vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'python2 ./install.py --tern-completer --racer-completer' } " code completion engine
" Plug 'Yggdroot/indentLine'    " display indentation levels with thin vertical lines
Plug 'godlygeek/tabular'      " text alignment
Plug 'mattn/emmet-vim' " web dev workflow toolkit
Plug 'pangloss/vim-javascript' " Vastly improved Javascript indentation and syntax
Plug 'bling/vim-airline' " status/tabline
Plug 'tpope/vim-sensible' " sensible defaults
Plug 'ctrlpvim/ctrlp.vim' " fuzzy finder
Plug 'scrooloose/syntastic' " syntax checking
Plug 'altercation/vim-colors-solarized' " Solarized color scheme
Plug 'kbarrette/mediummode' " limits character-wise motions
Plug 'sickill/vim-monokai' " Monokai color scheme
Plug 'tfnico/vim-gradle' " .gradle files as Groovy syntax
Plug 'tpope/vim-repeat' " `.` repeat for some plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'cohama/lexima.vim'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'LnL7/vim-nix'
call plug#end()

set number
set smartindent
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:syntastic_auto_loc_list = 1
let g:ycm_rust_src_path = '/usr/src/rust/src'
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab


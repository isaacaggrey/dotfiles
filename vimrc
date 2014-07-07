""""""""""""""""""""
" PLUGINS
""""""""""""""""""""
filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/Vundle.vim
endif

call vundle#rc()
Bundle 'gmarik/vundle'

" File & Edit Operations
Bundle 'SirVer/ultisnips'
Bundle 'git://repo.or.cz/vcscommand.git'
Bundle 'honza/vim-snippets'
Bundle 'kien/ctrlp.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'sjl/gundo.vim'
Bundle 'vim-pandoc/vim-pandoc'

" Movement & Text Objects
Bundle 'argtextobj.vim'
Bundle 'bkad/CamelCaseMotion'
Bundle 'dahu/vim-fanfingtastic'
Bundle 'jiangmiao/auto-pairs'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'goldfeld/vim-seek'

" UI
Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'
Bundle 'wting/rust.vim'
Bundle 'kbarrette/mediummode'

" Temporary

" Potential
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'scrooloose/syntastic'
"Bundle 'mileszs/ack.vim'
"Bundle 'on-chen/sack' " ag/ack enhancement
"Bundle 'burke/matcher' " Command-T like matcher for CtrlP
"Bundle 'airblade/vim-gitgutter' "shows git diff in gutter
"Bundle 'panozzaj/vim-autocorrect' "autocorrect for vim
"Bundle 'EasyGrep' "better interface into grep
"Bundle 'benmills/vimux' "integrate tmux with vim

"""""""""""""""""""" GLOBAL
set nocompatible
set shortmess=I

syntax enable
filetype plugin indent on
set autoread

if has('wildmenu')
  set wildignore+=*.class,*.dat,*.dll,*.exe,*.o,*.pdf,*.so
  if exists('&wildignorecase')
    set wildignorecase
  endif
endif

set noerrorbells
set visualbell
set t_vb=
set spell

"""""""""""""""""""" LOOK AND FEEL
colorscheme solarized
set t_Co=256
set background=dark
silent! set guifont=Inconsolata\ 14
if exists('&colorcolumn')
  set colorcolumn=80
endif
set softtabstop=4 tabstop=4 shiftwidth=4

highlight clear SpellBad
highlight SpellBad cterm=underline ctermfg=red

set expandtab
set number
set nohlsearch
set incsearch
set ignorecase
set smartcase
set cursorline
set backspace=indent,eol,start
set smartindent
set autoindent
set shiftround
set noswapfile
set ruler
set showcmd
set history=1000
set undolevels=1000
set writebackup
set listchars=tab:»·,trail:·,eol:¬,precedes:…,extends:…,nbsp:&

"""""""""""""""""""" KEYBINDINGS
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk
nnoremap <silent> 0 g0
nnoremap <silent> $ g$
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
nnoremap <Leader><Space> :set hlsearch<CR>
nnoremap <F4> :set list! list?<CR>
nnoremap <F12> :set paste! paste?<CR>
inoremap <silent><Up> <Esc>gka
inoremap <silent><Down> <Esc>gja
inoremap jj <Esc>
map N Nzz
map n nzz
nmap <space>f <Leader><Leader>f
nmap <space>F <Leader><Leader>F
nmap <C-l> gt
nmap <C-h> gT
nmap A $a
vmap <space>f <Leader><Leader>f
vmap <space>F <Leader><Leader>F
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
" Replace default 'w', 'b', 'e' mappings with CamelCase motion 
sunmap w
sunmap b
sunmap e
cmap w!! w !sudo tee % >/dev/null

"""""""""""""""""""" STATUS LINE
set laststatus=2                                       "always show status line

"""""""""""""""""""" PLUGIN OPTIONS
let g:solarized_termtrans = 1
let g:VCSCommandMapPrefix = '<Leader>f'
let g:ctrlp_open_new_file = 't'
let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v\.(git|hg|svn)$',
    \ 'file': '\v\.(o|out)$|(exe|so|dll)$|(tar.*|zip)$|class$|pdf$'}
    "\ 'link': 'some_bad_symbolic_links',
let g:ctrlp_user_command = {
    \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --exclude-standard'],
    \ 2: ['.hg', 'hg --cwd %s locate --include .'],
    \ },
    \ 'fallback': 'find %s -type f',
    \ }

"""""""""""""""""""" FILE SPECIFIC
let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'
let g:no_rust_conceal = 1
let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'

if has("autocmd")
  autocmd BufRead,BufNewFile *.txt set filetype=markdown
  autocmd BufRead,BufNewFile *.md set tabstop=4 softtabstop=4 shiftwidth=4 colorcolumn="" nonumber
  autocmd BufRead,BufNewFile haproxy* set ft=haproxy
endif

"""""""""""""""""""" FUNCTIONS
call togglebg#map("F5")

" DiffOrig: compare modified buffer with original file
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
                 \ | diffthis | wincmd p | diffthis

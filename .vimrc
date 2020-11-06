" Plugin Section

call plug#begin('~/.vim/bundle')
" Nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } |
  \ Plug 'Xuyuanp/nerdtree-git-plugin'

" Color schemes
Plug 'blueshirts/darcula'

" OSC52 (kitty clipboard)
Plug 'greymd/oscyank.vim'

" Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'

" FZF
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Bufexplorer
Plug 'jlanzarotta/bufexplorer'

" Goyo distraction free mode
" turn on with command :Goyo, turn off by :Goyo!
Plug 'junegunn/goyo.vim'

" Git
Plug 'airblade/vim-gitgutter'                                                " print changes on left of line numbers
Plug 'tpope/vim-fugitive'

" Docker file syntax
Plug 'ekalinin/Dockerfile.vim'

" Graphql syntax
Plug 'jparise/vim-graphql'

" TPope plugins
Plug 'tpope/vim-commentary'

" Toml
Plug 'cespare/vim-toml'

call plug#end()

" Global functions
source ~/.vim-config/.vimrc-lib

" COLORSCHEME
colorscheme darcula 
" Fix color in kitty term
if &term =~ 'xterm-kitty'
  set t_ut=
endif

" Main Configuration
syntax enable                                                                  " enable syntax 
let mapleader = ","                                                            " leader 
set number                                                                     " enable line numbers
set colorcolumn=80                                                             " set vertical column at 80
set exrc                                                                       " Load local .vimrc
set hidden                                                                     " Required for operations modifying multiple buffers like rename. 
set guicursor+=n-v-c:blinkon0                                                  " Cursor configuration  
set guicursor+=i:blinkwait10
set cmdheight=4                                                                " command line height
set tabstop=2                                                                  " tab size 
set shiftwidth=2
set expandtab                                                                  " On pressing tab, insert spaces 
set bs=2                                                                       " Fix backspace 
set fileformat=unix                                                            " Fix E418
set virtualedit=all                                                            " consent to move freely in the page even if there are no spaces 
set updatetime=300                                                             " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable 
setlocal foldlevel=99
setlocal foldmethod=syntax
set mouse=a                                                                    " enable mouse scrolling of Coc documentation 
set nobackup
set nowritebackup
set shortmess+=c

" Modules
source ~/.vim-config/nerdtree/.vimrc
source ~/.vim-config/fzf/.vimrc
source ~/.vim-config/airline/.vimrc

" Global mapping
source ~/.vim-config/.vimrc-mapping

" Global buffer config
source ~/.vim-config/.vimrc-buffer

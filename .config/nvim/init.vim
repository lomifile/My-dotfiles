set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set laststatus=2

nmap <C-a> :NERDTreeToggle<CR>
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap te :tabedit 
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set ttimeout
set ttimeoutlen=1
set ttyfast
set cursorline
set nocompatible
syntax enable
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'jparise/vim-graphql'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'c.vim'
Plugin 'rafi/awesome-vim-colorschemes'

" 1. source %
" 2. :PluginInstall
" 3. :call mkdp#util#install()

Plugin 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call vundle#end()           
filetype plugin indent on    
filetype plugin on

let g:coc_global_extensions = ['coc-tsserver']
let g:airline_powerline_fonts = 1
set t_Co=256
let g:airline_theme='afterglow'
colorscheme afterglow

let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()
 
    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

	
" User defined plugin
" 1. install Vundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible
filetype off

if g:islinux
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
else
    set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$VIM/vimfiles/bundle/')
endif


" Required
Plugin 'gmarik/Vundle.vim'
   
Plugin 'Lucius'
Plugin 'a.vim'
Plugin 'Align'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype on
filetype plugin on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
 
set fileformat=unix
set fileformats=unix,dos,mac 

set smartindent
set expandtab
set tabstop=4
set cindent shiftwidth=4
set autoindent shiftwidth=4
set smarttab

set autoread

" delete spaces at line end
nmap cS :%s/\s\+$//g<CR>:noh<CR>
nmap cM :%s/\r$//g<CR>:noh<CR>

set hlsearch
set incsearch
set ignorecase
set smartcase

set nu
set laststatus=2
" set cmdheight=2
" set cursorline
" set guifont=YaHei_Consolas_Hybrid:h10
" set nowrap
" set shortmess=atI"

colorscheme desert

" NERD tree
nmap <F2> :NERDTreeToggle<CR>

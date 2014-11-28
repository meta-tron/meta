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
" User defined 
Plugin 'Lucius'
Plugin 'a.vim'
Plugin 'Align'
Plugin 'jiangmiao/auto-pairs'
Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/nerdtree'
Plugin 'bufexplorer.zip'
Plugin 'OmniCppComplete'
Plugin 'std_c.zip'
" Plugin 'ccvext.vim' " <Leader>sy/sc
Plugin 'cSyntaxAfter'
Plugin 'flazz/vim-colorschemes'
" Plugin 'majutsushi/tagbar'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'taglist.vim'


" Need python interface
" Plugin 'Conque-Shell'
" Plugin 'Rip-Rip/clang_complete'

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
set fileencodings=utf-8,ucs-bom,cp936,gbk,gb2312,big5,latin1 
 
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
let mapleader=";"

set hlsearch
set incsearch
set ignorecase
set smartcase

set nu
" set guifont=Consolas:h11
colorscheme molokai
let g:molokai_original = 1
if g:islinux
    let g:rehash256 = 1
endif

" set cursorline
" set nowrap
" set shortmess=atI"
set nobackup

" change work dir to where the edited file lies
au BufRead,BufNewFile,BufEnter * cd %:p:h

" shortcut map
" clean spaces following line end
nmap cS :%s/\s\+$//g<CR>:noh<CR>
" clean ^M
nmap cM :%s/\r$//g<CR>:noh<CR>
" window moving
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" GUI tool bar, Ctrl+F11
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nmap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

" vim-powerline
set laststatus=2
set t_Co=256
" set cmdheight=2

" NERD tree
nmap <F2> :NERDTreeToggle<CR>

" cSyntaxAfter
au! BufRead,BufNewFile,BufEnter *.{c,cpp,h,java,javascript} call CSyntaxAfter()

" tagbar
nmap <F3> :TlistToggle<CR>

" OmniCppComplete
let OmniCpp_DefaultNamespaces = ['_GLIBCXX_STD']
map <F4> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++ .<CR>

set tags+=$HOME/.tags/stdcpp.tags
set tags+=$HOME/.tags/mecore.tags

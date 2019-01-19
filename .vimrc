""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""" Vundle Stuff """"""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable ancient vi compatibility
set nocompatible
filetype off " required, will fix shortly

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" For rendering markdown in a browser
Plugin 'JamshedVesuna/vim-markdown-preview'
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'
" for interacting with git
Plugin 'tpope/vim-fugitive'
" for easy surrounding with quotes, tags
Plugin 'tpope/vim-surround'
" powerline, a cool status bar
Plugin 'Lokaltog/vim-powerline'
Plugin 'benmills/vimux'
" Plugin 'julienr/vimux-pyutils'
Plugin 'julienr/vim-cellmode'
Plugin 'davidhalter/jedi-vim'
let g:jedi#force_py_version=3
" Plugin 'powerline/powerline'
" Plugin from https://github.com/scrooloose/sytastic
Plugin 'scrooloose/syntastic'
" syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Use pylint for syntax checking
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_python_pylint_exec = '/usr/local/bin/pylint'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""" End Vundle Stuff """"""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:cellmode_tmux_panenumber='1'

" Settings for powerline
set laststatus=2 " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

" so things are copied to system clipboard
set clipboard=unnamed

" use jj as <esc> alternative for exiting insert mode
inoremap jj <Esc>

" make backspace work right
set backspace=indent,eol,start

colo default
syntax enable
" wildmenu gives you tab completion on commands
set wildmenu
let g:netrw_banner=0 " disable annoying banner
" reload my vimrc
command! Vimrc execute "so $MYVIMRC"
" Give name of file
command! Name execute "echo @%"
" close buffer without closing window
command! Close execute "b#|bd#"
" run current python script with vimux
command! Pyrun call VimuxRunCommandInDir("python " . bufname("%"),0)
" start ipython session in current directory
command! Ipython call VimuxRunCommandInDir("ipython", 0)
" initializes python file
nnoremap ,py :-1read $HOME/.vim/.python_skeleton.py<CR>:4<CR>i
" initializes bash file
nnoremap ,sh :-1read $HOME/.vim/.bash_skeleton.sh<CR>:3<CR>i

" make Y behave like other capital letters
map Y y$
" improve up down movement on wrapped lines
nnoremap j gj
nnoremap k gk

"inoremap <C-l> <Esc>yyppkkI<<Esc>A><Esc>jI<tab><Esc>ld$jI</<Esc>ea> <Esc>DkA
"will show what I'm typing in lower left
set showcmd
set autoindent
set  tabstop=4
set shiftwidth=4
set expandtab
" set the mapleader key, so now q can act like a second control
let mapleader = ","
" for example, <leader>o will now enclose stuff in < />
inoremap <Leader>o <Esc>I<<Esc>A/><CR>
" makes inline xml tag
inoremap <Leader>h <Esc>yyppkkI<<Esc>A><Esc>jI<tab><Esc>ld$jI</<Esc>ea> <Esc>DkA
" multi line xml tag
inoremap <Leader>i <Esc>I<<Esc>lyeA></<Esc>pA><Esc>F<i
" wrap in xml comment
inoremap <Leader>c <Esc>I<!-- <Esc>A --><Esc>
" Code folding in normal mode
" za folds/unfolds at the cursor
" zm folds all, zn unfolds all
set foldmethod=indent
set foldlevel=99

" set pastetoggle to ,p
set pastetoggle=<leader>p

" more intuitive splits
map <c-w>\ <c-w>v<c-w>l
map <c-w>- <c-w>s<c-w>j

" show 80th column, which is the standard for python
set colorcolumn=80
highlight ColorColumn ctermbg=4

" execute the python file I'm editing
command! Python !python %
" auto indent
set smartindent

inoremap <Leader>l <C-o>l

" set .launch syntax to xml
au BufNewFile,BufRead *.launch set filetype=xml

" Enclose stuff in visual mode
vmap ," c""<Esc>Pl
vmap ,) c()<Esc>Pl
vmap ,( c()<Esc>Pl
vmap ,[ c[]<Esc>Pl
vmap ,] c[]<Esc>Pl
vmap ,{ c{}<Esc>Pl
vmap ,} c{}<Esc>Pl
vmap ' c''<Esc>Pl
vmap ' c''<Esc>Pl

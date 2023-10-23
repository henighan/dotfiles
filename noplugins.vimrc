filetype on


" Settings for powerline
set laststatus=2 " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors
set ttyfast " helps window not get screwed up when changing tmux panes

" so things are copied to system clipboard
set clipboard=unnamed

" use jj as <esc> alternative for exiting insert mode
inoremap jj <Esc>

" make backspace work right
set backspace=indent,eol,start

colo delek
syntax enable
" wildmenu gives you tab completion on commands
set wildmenu
let g:netrw_banner=0 " disable annoying banner
" reload my vimrc
command! Vimrc execute "so $MYVIMRC"
" Give name of file
command! Name execute "echo @%"
" initializes python file
nnoremap ,py :-1read $HOME/.vim/.python_skeleton.py<CR>:4<CR>i
" initializes bash file
nnoremap ,sh :-1read $HOME/.vim/.bash_skeleton.sh<CR>:3<CR>i
" python print variable
nnoremap ,e yiwoprint(f"{<Esc>pa=}")<Esc>
nnoremap ,i yiwolog.info(f"{<Esc>pa=}")<Esc>
vmap ,e yoprint(f"{<Esc>pa=}")<Esc>
vmap ,i yolog.info(f"{<Esc>pa=}")<Esc>
" break out definition of kwarg
nnoremap ,b byt,[(O<Esc>p^f=cl = <Esc>bb<c-o>yiwf=pldt,[(k$

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
" set the mapleader key
let mapleader = ","
" Code folding in normal mode
" za folds/unfolds at the cursor
" zm folds all, zn unfolds all
set foldmethod=indent
set foldlevel=99

" fzf
let $FZF_DEFAULT_OPTS = '--reverse'
command! -bang -nargs=? -complete=dir PFiles
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" set pastetoggle to ,p
set pastetoggle=<leader>p

" more intuitive splits
map <c-w>\ <c-w>v<c-w>l
map <c-w>- <c-w>s<c-w>j

" show column, which is the standard for python
" set colorcolumn=88
" highlight ColorColumn ctermbg=4

" execute the python file I'm editing
command! Python !python %
" auto indent
set smartindent

" set .launch syntax to xml
au BufNewFile,BufRead *.launch set filetype=xml

" Enclose stuff in visual mode
vmap ,) c()<Esc>Pl
vmap ,( c()<Esc>Pl%
vmap ,] c[]<Esc>Pl
vmap ,[ c[]<Esc>Pl%
vmap ,} c{}<Esc>Pl
vmap ,{ c{}<Esc>Pl%
vmap ' c''<Esc>Pl
vmap ," c""<Esc>Pl
vmap ,` c``<Esc>Pl
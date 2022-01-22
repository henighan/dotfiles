""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""" Plugin Stuff """"""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable ancient vi compatibility
set nocompatible
filetype off " required, will fix shortly

call plug#begin('~/.vim/plugged')

" For rendering markdown in a browser
Plug 'JamshedVesuna/vim-markdown-preview'
let vim_markdown_preview_hub=1 " ctrl-p
let vim_markdown_preview_browser='Google Chrome'
" Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
" let g:pydocstring_formatter='sphinx'
" for autocomplete when doing search or search-n-replace
Plug 'vim-scripts/sherlock.vim'
cnoremap <C-j> <C-\>esherlock#completeForward()<CR>
cnoremap <C-k> <C-\>esherlock#completeBackward()<CR>
" for interacting with git
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'
" command! Mdiff execute "Gvdiff master"
" for easy surrounding with quotes, tags
Plug 'tpope/vim-surround'
" powerline, a cool status bar
" Plug 'Lokaltog/vim-powerline'
Plug 'vim-airline/vim-airline'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#branch#displayed_head_limit = 7
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" :Bdelete
Plug 'moll/vim-bbye'
Plug 'junegunn/gv.vim'
" show git +/-/~ in gutter
Plug 'airblade/vim-gitgutter'
highlight! link SignColumn LineNr
" Plug 'benmills/vimux'
" " Plug 'julienr/vimux-pyutils'
" Plug 'julienr/vim-cellmode'
Plug 'davidhalter/jedi-vim'
" let g:jedi#force_py_version=3
" let g:jedi#show_call_signatures = "1"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
Plug 'w0rp/ale'
let g:ale_linters = {'python': ['pylint']}
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'scrooloose/nerdtree'
" Plug 'python/black'
let g:black_linelength = 88
" Plug 'psf/black', { 'tag': '19.3b0' }
" let g:black_virtualenv='/Users/henighan/miniconda3/envs/py375'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" autocmd BufWritePost *.py silent! execute ':Black'
" Use pylint for syntax checking
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_python_pylint_args = '-E'
" let g:syntastic_python_pylint_exec = '/usr/local/bin/pylint'
Plug 'tell-k/vim-autoflake'
" Plug 'ycm-core/YouCompleteMe'
" let g:ycm_filetype_specific_completion_to_disable = { 'python' : 1 }
" let g:ycm_filetype_blacklist = { 'python' : 1 }
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Allows you do do search-n-replace across multiple files in cwindow
" TODO make :grep -r ... shortcut for python files
Plug 'stefandtw/quickfix-reflector.vim'

" Initialize plugin system
call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""" End Plugin Stuff """"""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on

" a coc thing
" autocmd FileType yaml inoremap <silent><expr> <C-Space> coc#refresh()

let g:cellmode_tmux_panenumber='2'

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
" close buffer without closing window - supercede by Bdelete
" command! Close execute "b#|bd#"
" run current python script with vimux
command! Pyrun call VimuxRunCommandInDir("python " . bufname("%"),0)
" start ipython session in current directory
command! Ipython call VimuxRunCommandInDir("ipython", 0)
" initializes python file
nnoremap ,py :-1read $HOME/.vim/.python_skeleton.py<CR>:4<CR>i
" initializes bash file
nnoremap ,sh :-1read $HOME/.vim/.bash_skeleton.sh<CR>:3<CR>i
" python print variable
nnoremap ,e yiwoprint(f"{<Esc>pa=}")<Esc>
nnoremap ,i yiwoinfo(f"{<Esc>pa=}")<Esc>
vmap ,e yoprint(f"{<Esc>pa=}")<Esc>
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

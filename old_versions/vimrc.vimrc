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
source ./noplugins.vimrc
" a coc thing
" autocmd FileType yaml inoremap <silent><expr> <C-Space> coc#refresh()

let g:cellmode_tmux_panenumber='2'
" run current python script with vimux
command! Pyrun call VimuxRunCommandInDir("python " . bufname("%"),0)
" start ipython session in current directory
command! Ipython call VimuxRunCommandInDir("ipython", 0)
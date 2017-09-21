set nocompatible
filetype on
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'rizzatti/dash.vim'
Plugin 'othree/html5.vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'elzr/vim-json'
Plugin 'kchmck/vim-coffee-script'
Plugin 'wavded/vim-stylus'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'rstacruz/sparkup'
Plugin 'othree/yajs.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'editorconfig/editorconfig'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'shougo/deoplete.nvim'
Plugin 'zchee/deoplete-jedi'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'evidens/vim-twig'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on

" nerdtree config
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim airline config
"let g:airline_powerline_fonts = 1
set laststatus=2

" go away linter
let g:syntastic_python_checkers = []
let g:syntastic_javascript_checkers = ['eslint']

" vim multiple cursors config
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-b>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" JSBeautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" deoplete
" let g:deoplete#enable_at_startup = 1

"" PYTHON SPECIFICS

" code folding
set foldmethod=indent
set foldlevel=99
" bind to space
nnoremap <space> za

" highlight extraneous whitespace
highlight BadWhitespace guifg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" highlighting
let python_highlight_all=1
set background=dark

let g:UltiSnipsExpandTrigger="<tab>"


syntax on
set nu
set pastetoggle=<F2>
set tabstop=8
set shiftwidth=8
set noexpandtab

" ipad keyboard workaround
inoremap <M-Space> <Esc>

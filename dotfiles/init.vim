set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

" Quality of life
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'w0rp/ale'
Plug 'mtth/scratch.vim'
Plug 'godlygeek/tabular'
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-dispatch'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'jaxbot/github-issues.vim'

" Text editing
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'plasticboy/vim-markdown'

" Orgmode deps
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'

" JS support
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'maksimr/vim-jsbeautify'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'tikhomirov/vim-glsl'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" Rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

" JS tagbars
Plug 'majutsushi/tagbar'

" Indentation/Project Mgmt
" Plug 'tpope/vim-sleuth'

" Markdown
Plug 'gabrielelana/vim-markdown'

" HTML
Plug 'rstacruz/sparkup'

" Python
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
Plug 'vim-python/python-syntax'
"Plug 'pixelneo/vim-python-docstring'

" Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'bitc/vim-hdevtools'

" GraphQL
Plug 'jparise/vim-graphql'

" PDDL
Plug 'PontusPersson/pddl.vim'

" TeX
""Plug 'lervag/vimtex'

call plug#end()
filetype plugin indent on

" editor configuration
set background=dark
set nu
set laststatus=2
set pastetoggle=<F2>
set foldlevelstart=99
set encoding=UTF-8
set signcolumn=yes
" movement (turned off)
"nmap j jzz
"nmap k kzz

" set termguicolors
nnoremap <space> za

" indentation
set tabstop=4
set shiftwidth=4
set expandtab


" tabgar
nmap <F8> :TagbarToggle<CR>

" highlight extraneous whitespace
highlight BadWhitespace guifg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
au BufRead,BufNewFile * match BadWhitespace /\s\+$/

" nerdtree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeHijackNetrw=1

" vim multiple cursors config
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-b>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" easyalign configuration
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" orgmode config
let g:org_todo_keywords=['GOAL', 'SCHEDULED', 'ACTIVE', 'TODO', 'DONE', 'PUNTED']
let g:org_agenda_files=['~/.config/org/index.org']
autocmd FileType org set expandtab | set shiftwidth=4 | set tabstop=4

" ctrl-p configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_custom_ignore = '\v[\/](env_*|node_modules|\.(git|hg|svn))$'

" undotree
nnoremap <F5> :UndotreeToggle<cr>

" Disable ALE unless we need it
let g:ale_enabled=0

" javascript lang-specific setup
augroup javascript_folding
    au FileType javascript setlocal foldmethod=syntax
augroup END
let g:javascript_plugin_jsdoc = 1
autocmd FileType javascript noremap <buffer>  <c-f> :call JsxBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': []
\}

" Rust QoL stuff
augroup tera_ft
  au!
  autocmd BufNewFile,BufRead *.html.tera   set syntax=html
augroup END

" 80/100 width color column
highlight ColorColumn ctermbg=black
set colorcolumn=80,100
command LightMode highlight ColorColumn ctermbg=lightgray | set background=light
command DarkMode highlight ColorColumn ctermbg=black | set background=dark


" CSS/SCSS color config
let g:Hexokinase_ftAutoload = ['css', 'xml', 'scss']

" deoplete config
let g:deoplete#enable_at_startup = 1

" haskell
au FileType haskell ALEEnable

" svelte crap
let g:svelte_indent_script = 0
let g:svelte_indent_style = 0

" disable line numbers in terminal
autocmd TermOpen * setlocal nonumber norelativenumber

" set color for floating windows
highlight CocFloating ctermbg=black

" for live notetaking - save on enter
command LiveSaving inoremap <enter> <Esc>:w<enter>A<enter>

" Writing configuration
command W w
command WriteMode set tw=79 | set fo+=t | Goyo 85 | echo "Write mode enabled."
command WriteModeDisable set fo-=t | Goyo | echo "Write mode disabled."
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" some bullshit for latex
" Custom Silent command that will call redraw
command! -nargs=+ Silent
\   execute 'silent ! <args>'
\ | redraw!

map <leader>ll :!pdflatex -synctex=1 %<cr>
" (if using preview)
" map <leader>ll :Silent pdflatex % && open -a Preview && open -a iTerm<cr>
map <leader>lm :Silent make && open -a Preview && open -a iTerm<cr>
map <leader>lb :Make biblio<cr>
map <leader>ls :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR><CR>

" commentary
vnoremap <C-/> :Commentary<CR>

" fix some gutter stuff
highlight! link SignColumn LineNr

" pydocstring stuff
let g:pydocstring_doq_path = "/Library/Frameworks/Python.framework/Versions/3.8/bin/doq"

" other python
let g:python_highlight_all = 1

" EJS template highlighting
au BufNewFile,BufRead *.ejs set filetype=html

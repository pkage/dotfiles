set nocompatible

" plugin config
lua require('plugins')


" editor configuration
set background=dark
set nu
set laststatus=2
set pastetoggle=<F2>
set foldlevelstart=99
set encoding=UTF-8
" set termguicolors


" indentation
set tabstop=4
set shiftwidth=4
set expandtab


" some keybinds
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <C-p> :lua require'telescope.builtin'.find_files{}<CR>

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim multiple cursors config
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-b>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'


" Writing configuration
command W w
command WriteMode set tw=79 | set fo+=t | Goyo 85 | echo "Write mode enabled."
command WriteModeDisable set fo-=t | Goyo | echo "Write mode disabled."
let g:limelight_conceal_ctermfg = 'gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Some bullshit for the sign column
highlight SignColumn ctermbg=black

" some bullshit for latex
" Custom Silent command that will call redraw
command! -nargs=+ Silent
\   execute 'silent ! <args>'
\ | redraw!


map <leader>ll :!pdflatex -synctex=1 %<cr>
map <leader>lm :Silent make && open -a Preview && open -a iTerm<cr>
map <leader>lb :Make biblio<cr>
map <leader>ls :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR><CR>

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
function WriteModeEnable()
    " inoremap <C-n> <C-O>:lua require'cmp'.complete()
    set tw=79
    set fo+=t
    Goyo 85
    Gitsigns detach
    echo "Write mode enabled."
endfunction

" command CmpOff lua require'cmp'.setup { completion = { autocomplete = false } }
" command CmpOn  lua require'cmp'.setup { completion = { autocomplete = true  } }

command W w
" command WriteMode set tw=79 | set fo+=t | Goyo 85 | Gitsigns toggle_signs | echo "Write mode enabled."
command WriteMode call WriteModeEnable()
command WriteModeDisable set fo-=t | Goyo | Gitsigns attach | echo "Write mode disabled."
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

" ejs support
au BufNewFile,BufRead *.ejs set filetype=html.js

" hop config
map <leader><leader>w :HopWord<cr>
map <leader><leader>b :HopWordBC<cr>
map <leader><leader>l :HopLine<cr>


" tex support
map <leader>ll :!lualatex -synctex=1 %<cr>
map <leader>lm :make<cr>
map <leader>lb :make biblio<cr>
map <leader>ls :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf<CR><CR>

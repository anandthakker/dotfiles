execute pathogen#infect()

set number
set showcmd
set selectmode=mouse

set nocompatible
set nowritebackup
set noswapfile
set nobackup

filetype plugin on
filetype indent on
set autoindent
set indentexpr=off
set tabstop=2
set sw=2
set expandtab

set wildmenu

syntax on
colorscheme solarized
call togglebg#map("<F5>")

set incsearch

set runtimepath^=~/.vim/bundle/ctrlp.vim

inoremap jk <esc>
" \s to initiate search and replace for word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
" \r to replace the last yanked(deleted/changed) word with last inserted text
" e.g.: cursor on a word, ciwNewWord<esc>, \r to repeat the change across the
" whole file
nnoremap <Leader>r :%s/\<<c-r>"\>/<c-r>./g


" ultisnips
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" delimitMate
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']

" up the font size
set guifont=Menlo\ Regular:h13



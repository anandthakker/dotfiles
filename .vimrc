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
if 0
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" FindRc() will try to find a .jshintrc up the current path string
" If it cannot find one it will try looking in the home directory
" finally it will return an empty list indicating jshint should use
" the defaults.
function! g:FindRc(path)
  let l:jshintrc_file = fnamemodify(a:path, ':p') . '.jshintrc'
  echo l:jshintrc_file
  if filereadable(l:jshintrc_file)
    return 1
  elseif len(a:path) > 1
    return g:FindRc(fnamemodify(a:path, ":h"))
  else
    return 0
  endif
endfun

function! g:setJavascriptChecker()
  if g:FindRc(expand('%:p:h'))
    echo "jshint"
    let b:syntastic_checkers = ["jshint"] |
  else
    echo "standard"
    let b:syntastic_checkers = ["standard"] |
  endif
endfun

autocmd FileType javascript call g:setJavascriptChecker()

" up the font size
set guifont=Menlo\ Regular:h13



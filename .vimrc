set nocompatible
set ruler
set bs=2
set vb
set background=dark
set autoindent
set expandtab
set softtabstop=4
set shiftwidth=4
set smarttab
set smartindent
set backspace=indent,eol,start
set incsearch
set showcmd
set wildmenu
map  :w!<CR>:!aspell check %<CR>:e! %<CR>
map <Tab><Tab> <C-W>w

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

highlight OverLength ctermbg=red ctermfg=white guibg=red
match OverLength /\%81v.\+/

call pathogen#infect()
syntax on
filetype plugin indent on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
" Disable PHP style checking cos my style sucks
let g:syntastic_phpcs_disable=1

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2


" Persistent undo
try 
    set undodir=~/.vim/undodir
    set undofile
    set undolevels=1000
    set undoreload=10000
catch
endtry

" Jump to the last place you were in a file automatically
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal! g'\"" | endif
endif

" Add argument (can be negative, default 1) to global variable i.
" Return value of i before the change.
function Inc(...)
  let result = g:i
  let g:i += a:0 > 0 ? a:1 : 1
  return result
endfunction

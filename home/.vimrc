set nocompatible

call pathogen#infect()
syntax enable
set encoding=utf-8
set showcmd
filetype plugin indent on
au BufNewFile,BufRead *.inc set filetype=php

"let g:solarized_termcolors=256
set background=light
colorscheme solarized

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

:imap jj <Esc>
:imap kk <Esc>

set nowrap
set tabstop=2 shiftwidth=2
set expandtab
set softtabstop=2
set backspace=indent,eol,start
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set hidden
set fdc=2
set laststatus=2
set t_Co=256
set isk+=$

let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn|\.DS_Store$'

" Backups
set history=1000
set undolevels=1000
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" Undo files
set undofile
set undodir=~/.vim/tmp/undos//

:let mapleader = ","
map <Leader>g :Gstatus<CR>

if has("gui_running")
  set guioptions=egmrt
endif

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  au! BufWritePost .vimrc source %

endif
 " Enable autosave
  :au FocusLost * :%s/\s\+$//e
  :au FocusLost * silent! wa

au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")
autocmd BufWritePre * :%s/\s\+$//e

" Awesome arrow bindings
" ------------------
function! DelEmptyLineAbove()
    if line(".") == 1
        return
    endif
    let l:line = getline(line(".") - 1)
    if l:line =~ '^\s*$'
        let l:colsave = col(".")
        .-1d
        silent normal! <C-y>
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineAbove()
    let l:scrolloffsave = &scrolloff
    " Avoid jerky scrolling with ^E at top of window
    set scrolloff=0
    call append(line(".") - 1, "")
    if winline() != winheight(0)
        silent normal! <C-e>
    endif
    let &scrolloff = l:scrolloffsave
endfunction

function! DelEmptyLineBelow()
    if line(".") == line("$")
        return
    endif
    let l:line = getline(line(".") + 1)
    if l:line =~ '^\s*$'
        let l:colsave = col(".")
        .+1d
        ''
        call cursor(line("."), l:colsave)
    endif
endfunction

function! AddEmptyLineBelow()
    call append(line("."), "")
endfunction

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent
function! SetArrowKeysAsTextShifters()
    " normal mode
    nmap <silent> <Left> <<
    nmap <silent> <Right> >>
    nnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>
    nnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>
    nnoremap <silent> <D-Up> <Esc>:call DelEmptyLineBelow()<CR>
    nnoremap <silent> <D-Down> <Esc>:call AddEmptyLineBelow()<CR>

    " visual mode
    vmap <silent> <Left> <
    vmap <silent> <Right> >
    vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv
    vnoremap <silent> <Down>  <Esc>:call AddEmptyLineAbove()<CR>gv
    vnoremap <silent> <D-Up> <Esc>:call DelEmptyLineBelow()<CR>gv
    vnoremap <silent> <D-Down> <Esc>:call AddEmptyLineBelow()<CR>gv

    " insert mode
    imap <silent> <Left> <C-D>
    imap <silent> <Right> <C-T>
    inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
    inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a
    inoremap <silent> <D-Up> <Esc>:call DelEmptyLineBelow()<CR>a
    inoremap <silent> <D-Down> <Esc>:call AddEmptyLineBelow()<CR>a

    " disable modified versions we are not using
    " nnoremap  <S-Up>     <NOP>
    " nnoremap  <S-Down>   <NOP>
    " nnoremap  <S-Left>   <NOP>
    " nnoremap  <S-Right>  <NOP>
    " vnoremap  <S-Up>     <NOP>
    " vnoremap  <S-Down>   <NOP>
    " vnoremap  <S-Left>   <NOP>
    " vnoremap  <S-Right>  <NOP>
    " inoremap  <S-Up>     <NOP>
    " inoremap  <S-Down>   <NOP>
    " inoremap  <S-Left>   <NOP>
    " inoremap  <S-Right>  <NOP>
endfunction
call SetArrowKeysAsTextShifters()

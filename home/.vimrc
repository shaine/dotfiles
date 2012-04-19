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


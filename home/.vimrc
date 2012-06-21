" Setup
set nocompatible " Don't need vi compatibility
call pathogen#infect() " Start Pathogen to load bundles
call pathogen#helptags() " Pathogen to load help tags
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
syntax enable " Enable syntax highlighting
set encoding=utf-8 " Files should always be UTF8
filetype plugin indent on " Auto indent
au BufNewFile,BufRead *.inc set filetype=php " Explicit filetypes

" Colorscheme
"let g:solarized_termcolors=256
"let g:solarized_termtrans = 1
set background=light
colorscheme solarized

" Key mappings for pane selection
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap _ :sp<CR><C-w>j
nnoremap \| :vsp<CR><C-w>l
noremap <leader>t :tabe<CR>

" Extra escape bindings
:imap jj <Esc>
:imap kk <Esc>

" Other custom keymappings
:let mapleader = ","

" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" Fugitive
map <Leader>g :Gstatus<CR>

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" Gundo configuration
map <Leader>u :GundoToggle<CR>

" Other bindings
nmap <silent> // :nohlsearch<CR> " Clear search

let g:user_zen_settings = {
\  'indentation' : '  ',
\  'php' : {
\    'aliases' : {
\      'req' : 'require '
\    },
\    'snippets' : {
\      'php' : "<?php | ?>",
\      'yii' : "Yii::app()->",
\      'yiijs' : "Yii::app()->clientScript->registerScriptFile(\"|\");",
\      'yiicss' : "Yii::app()->clientScript->registerCssFile(\"|\");",
\    }
\  }
\}

" CtrlP
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn|\.DS_Store$'
let g:ctrlp_map = '<Leader>f'

" Powerline
let g:Powerline_symbols = 'fancy'
" let g:Powerline_theme='skwp'
let g:Powerline_colorscheme='skwp'

set showcmd " Show location info in lower right
set nowrap " Don't line wrap
set tabstop=2 shiftwidth=2 " Set tabs to softab 2
set expandtab " Turn tabs to spaces
set softtabstop=2 " Something else about tabs
set list listchars=tab:\ \ ,trail:· " Visuall show bad whitespace
set backspace=indent,eol,start " Set what we can backspace through
set number " Show line numbers
set hlsearch " Highlight search matches
set incsearch " Show next match while typing search
set ignorecase " Case insensitive searches
set smartcase " Searches respect case if it's obvious that it's important
set hidden " Allow unsaved buffers to be 'closed'
set fdc=0 " Column for folding indicators
set laststatus=2 " Always show status line
set t_Co=256 " 256 colors
set isk+=$ " Add word characters
set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Plugin settings

" Undo files
set history=1000
set undolevels=1000
set undofile
set undodir=~/.vim/tmp/undos//
set noswapfile
set nobackup
set nowb

if has("gui_running")
  set guioptions=egmrt
endif

if !exists("autocommands_loaded")
  let autocommands_loaded = 1

  au! BufWritePost .vimrc source %
endif

" Enable autosave
au FocusLost * :%s/\s\+$//e " Remove trailing spaces on focus lost
au FocusLost * silent! wa " Write file on focus lost
au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>") " Leave focus mode on focus lost
autocmd BufWritePre * :%s/\s\+$//e " Remove trailing space on save

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
    "inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a
    "inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a
    "inoremap <silent> <D-Up> <Esc>:call DelEmptyLineBelow()<CR>a
    "inoremap <silent> <D-Down> <Esc>:call AddEmptyLineBelow()<CR>a

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

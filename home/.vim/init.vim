" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'shaine/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'
Plug 'dylanaraps/ryuuko'
Plug 'dylanaraps/crayon'
Plug 'dylanaraps/wal'

" Languages
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
" Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
" Plug 'othree/yajs.vim', { 'for': 'javascript' }
" Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'sheerun/vim-polyglot'

" Tools
Plug 'vim-scripts/YankRing.vim' " Yank/paste ring
Plug 'ervandew/supertab' " Auto-complete with tab
Plug 'sitaktif/vim-space' " Some sort of tab/delete motion repeat
" Plug 'gregsexton/MatchTag' " Match the end of a tag
Plug 'tpope/vim-surround' " Operate with surrounds or within surrounds
Plug 'Raimondi/delimitMate' " Auto-close quotes
Plug 'tpope/vim-fugitive' " Git integration
Plug 'mattn/webapi-vim' " For gist-vim
Plug 'mattn/gist-vim' " Publish to github gists
Plug 'scrooloose/nerdtree', " File explorer
Plug 'jistr/vim-nerdtree-tabs' " NERDTree across tabs
Plug 'sjl/gundo.vim', " Undo UI
" Plug 'airblade/vim-gitgutter' " Git status in gutter
Plug 'tpope/vim-repeat' " Better . repeating
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale' " Linter
call plug#end()

" Colorscheme
set background=dark
colorscheme ryuuko
" colorscheme wal
" colorscheme one
let g:airline_theme = 'serene'
" Highlight columns beyond 120
execute "set colorcolumn=" . join(range(121,121), ',')
" set termguicolors
hi! ColorColumn ctermbg=16
hi! VertSplit ctermfg=16
hi! MatchParen cterm=none ctermbg=green ctermfg=white
hi! CursorParen cterm=none ctermbg=white ctermfg=green

" Setup
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable auto-comment
au BufNewFile,BufRead *.tmux set filetype=tmux " Explicit filetypes - tmux
au BufNewFile,BufRead *.conf set filetype=xml " Explicit filetypes - conf
autocmd BufNewFile,BufReadPost *.md set filetype=markdown " Explicit filetypes - markdown
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces() " Remove trailing space on save
let mapleader = ","

augroup nvim_term
  au!
  au TermOpen * startinsert
  au TermClose * stopinsert
augroup END

" Shortcuts
" Reload configuration
nnoremap <leader>S :so ~/.vim/init.vim<cr>
" Sudo write me a sandiwch
if !exists(":Write")
  command Write w !sudo tee % > /dev/null
endif

" Key mappings for pane selection
nmap <silent> <C-h> <c-w>h
nmap <silent> <C-j> <c-w>j
nmap <silent> <C-k> <c-w>k
nmap <silent> <C-l> <c-w>l
nnoremap _ :sp<CR><C-w>j
nnoremap \| :vsp<CR><C-w>l
nnoremap <leader>t :tabe<CR>
" Keep the splits always equal in size
autocmd VimResized * wincmd =
" Switch from terminal to normal mode
tnoremap <Esc> <C-\><C-n>

" Swap word left/right
nnoremap H :let @h=@/<CR>"_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>:let @/=@h<CR>
nnoremap L :let @l=@/<CR>"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>/\w\+\_W\+<CR><C-l>:let @/=@l<CR>
" Swap line(s) up/down
nnoremap K :m-2<CR>==
vnoremap K :m-2<CR>gv=gv
nnoremap J :m+<CR>==
vnoremap J :m'>+<CR>gv=gv

" Re-add join feature
nnoremap <leader>J :join<cr>

" Extra escape bindings
inoremap jj <Esc>
inoremap kk <Esc>
inoremap jk <Esc>

" Copy editing undo chunking
inoremap . .<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap , ,<c-g>u

" Other bindings
nmap <silent> // :nohlsearch<CR>" Clear search
" Don't jump when setting current word to search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *N
" Force redraw
nmap <leader>r :redraw!<CR>
nnoremap Q <nop>
nnoremap <Space> a_<Esc>r
command! Q q

" Swap ` and ' for better tmux integration
nnoremap ' `
nnoremap ` '

" Undo files
set history=1000
set undolevels=1000
set undofile
set undodir=~/.vim/tmp/undo//
set noswapfile
set nobackup
set nowb

" General
set showcmd " Don't show command output
set nowrap " Don't line wrap
set tabstop=2 shiftwidth=2 " Set tabs to softab 2
set expandtab " Turn tabs to spaces
set softtabstop=2 " Something else about tabs
set list listchars=tab:\ \ ,trail:· " Visuall show bad whitespace
set backspace=indent,eol,start " Set what we can backspace through
set nonumber " show no line numbers
set hlsearch " Highlight search matches
set incsearch " Show next match while typing search
set ignorecase " Case insensitive searches
set smartcase " Searches respect case if it's obvious that it's important
set hidden " Allow unsaved buffers to be 'closed'
set fdc=0 " Column for folding indicators
set laststatus=2 " Always show status line
set noshowmode " Don't show the mode text
set t_Co=256 " 256 colors
set isk+=$ " Add word characters
set scrolloff=8 "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
" set cursorline
set synmaxcol=800 " Don't try to highlight lines longer than 800 characters.
" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"
set mouse=a

" Close quickfix if it's the only open window
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

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
    nnoremap <silent> <Down>    <Esc>:call AddEmptyLineAbove()<CR>
    nnoremap <silent> <D-Up> <Esc>:call DelEmptyLineBelow()<CR>
    nnoremap <silent> <D-Down> <Esc>:call AddEmptyLineBelow()<CR>

    " visual mode
    vmap <silent> <Left> <
    vmap <silent> <Right> >
    vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv
    vnoremap <silent> <Down>    <Esc>:call AddEmptyLineAbove()<CR>gv
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
    " nnoremap    <S-Up>         <NOP>
    " nnoremap    <S-Down>     <NOP>
    " nnoremap    <S-Left>     <NOP>
    " nnoremap    <S-Right>    <NOP>
    " vnoremap    <S-Up>         <NOP>
    " vnoremap    <S-Down>     <NOP>
    " vnoremap    <S-Left>     <NOP>
    " vnoremap    <S-Right>    <NOP>
    " inoremap    <S-Up>         <NOP>
    " inoremap    <S-Down>     <NOP>
    " inoremap    <S-Left>     <NOP>
    " inoremap    <S-Right>    <NOP>
endfunction
call SetArrowKeysAsTextShifters()

hi Normal guibg=NONE ctermbg=NONE
" hi! Search term=standout gui=standout guibg=#96c475 guifg=#000000

" Ack.vim
if executable('ag')
  " Configure ack.vim to use ag
  let g:ackprg = 'ag --vimgrep --smart-case'
  " Don't open first file by default
  cnoreabbrev Ag Ack!
  cnoreabbrev Ack Ack!
endif

" Airline
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#nerdtree_status = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#fnametruncate = 15
let g:airline_mode_map = {
  \ '__' : '------',
  \ 'c'  : 'C',
  \ 'i'  : 'I',
  \ 'ic' : 'IC',
  \ 'ix' : 'IC',
  \ 'multi' : 'M',
  \ 'n'  : 'N',
  \ 'ni' : 'I',
  \ 'no' : 'OP PENDING',
  \ 'R'  : 'R',
  \ 'Rv' : 'VR',
  \ 's'  : 'S',
  \ 'S'  : 'SL',
  \ '' : 'SB',
  \ 't'  : 'T',
  \ 'v'  : 'V',
  \ 'V'  : 'VL',
  \ '' : 'VB',
  \ }

let g:airline_section_y = ''
let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', ':%3v'])

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''

" ALE
let g:ale_linters_ignore = ['reek']

" FZF
map <Leader>f :FZF<CR>
nnoremap <silent> <leader>G :Ag <C-R><C-W><CR>
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Fugitive
map <Leader>g :Gstatus<CR>

" Gist
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

" Gundo configuration
map <Leader>u :GundoToggle<CR>

" NERDTree
nnoremap <silent> <leader>F :NERDTreeTabsToggle<CR>

" Paste toggle
nnoremap <Leader>v :set invpaste paste?<CR>

" Space.vim related
let g:space_no_second_prev_mapping = 1
let g:space_no_jump = 1
nmap <Tab> <Plug>SmartspaceNext
nmap <BS> <Plug>SmartspacePrev
nnoremap <Space> a_<Esc>r

" Yankring
let g:yankring_history_dir = '~/.vim/tmp/yank'
" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y
noremap <leader>p :set paste<CR>:put    *<CR>:set nopaste<CR> " Preserve indentation while pasting text from the OS X clipboard
" Paste at the end of the line
nnoremap <Leader>P ma$p`a

" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

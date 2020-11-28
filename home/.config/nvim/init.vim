" vim-plug
call plug#begin('~/.config/nvim/plugged')
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
Plug 'sheerun/vim-polyglot',
Plug 'fatih/vim-go'
Plug 'mboughaba/i3config.vim'
Plug 'vimwiki/vimwiki'
Plug 'shaine/vim-zettel'

" Tools
Plug 'vim-scripts/YankRing.vim' " Yank/paste ring
Plug 'ervandew/supertab' " Auto-complete with tab
Plug 'sitaktif/vim-space' " Some sort of tab/delete motion repeat
" Plug 'chmp/mdnav' " Navigate markdown links
Plug 'tpope/vim-surround' " Operate with surrounds or within surrounds
Plug 'Raimondi/delimitMate' " Auto-close quotes
Plug 'tpope/vim-fugitive' " Git integration
Plug 'mattn/webapi-vim' " For gist-vim
Plug 'mattn/gist-vim' " Publish to github gists
Plug 'scrooloose/nerdtree', " File explorer
Plug 'jistr/vim-nerdtree-tabs' " NERDTree across tabs
Plug 'sjl/gundo.vim', " Undo UI
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
autocmd FileType markdown
      \ set wrap linebreak |
      \ set autoread |
      \ autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif

" Sort nerdtree by time when in the notes directory, and change other annoying options
autocmd VimEnter *
      \ if getcwd() =~ "Documents/notes" | let NERDTreeSortOrder=['\/$', '*', '[[-timestamp]]'] | endif |
      \ DelimitMateOff |
      \ map <Leader>f :ZettelOpen<CR>

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
nnoremap <leader>S :so ~/.config/nvim/init.vim<cr>
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
set undodir=~/.config/nvim/tmp/undo//
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

" For privacy
function Private()
  set history=0
  set nobackup
  set nomodeline
  set noshelltemp
  set noswapfile
  set noundofile
  set nowritebackup
  set secure
  set viminfo=""
endfunction

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
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
" Auto close when only window remaining
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Paste toggle
nnoremap <Leader>v :set invpaste paste?<CR>

" Space.vim related
let g:space_no_second_prev_mapping = 1
let g:space_no_jump = 1
nmap <Tab> <Plug>SmartspaceNext
nmap <BS> <Plug>SmartspacePrev
nnoremap <Space> a_<Esc>r

" vimwiki
function! s:insert_id()
      if exists("g:zettel_current_id")
            return g:zettel_current_id
      else
            return "unnamed"
      endif
endfunction

function! VimwikiLinkHandler(link)
      if a:link =~ '\.\(pdf\|jpg\|jpeg\|png\|gif\)$'
            call vimwiki#base#open_link(':e ', 'file:'.a:link)
            return 1
      endif
      return 0
endfunction

" Vimwiki and vim-zettel
function! InsertDate()
      put =strftime('%Y-%m-%d %H:%M')
endfun
" ZettelCapture + add wiki header first
command! ZC :norm gg0lly$O---title: "date: jj:call InsertDate()k,Jo---jj:w:ZettelCapture
" Fix chrome markdown clipper links
command! ZL :norm G$?Source%%ll"zy3t/o":s/\//\\\//g0"zy$dd:%s/chrome-extension:\/\/.\{-}\//z\//g

nmap <Leader>zi :ZettelInbox<cr>
nmap <Leader>zo :ZettelOpen<cr>
" nmap <Leader>zd :call InsertDate()<cr>
nmap <Leader>zd :VimwikiDiaryGenerateLinks<cr>
nmap <Leader>zc :ZL<cr>:ZC<cr>
nmap <Leader>zl :ZL<cr>
nmap <Leader>zn :ZettelNew<space>
" vmap zn y:ZettelNew "

let g:vimwiki_auto_header = 1
let g:vimwiki_hl_headers = 1
let g:vimwiki_list = [{
\'path': '~/Documents/notes/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1, 'links_space_char': '-'
\}, {
\'path': '~/Documents/dungeons-and-dragons/', 'syntax': 'markdown', 'ext': '.md', 'links_space_char': '-'
\}, {
\'path': '~/Downloads/', 'syntax': 'markdown', 'ext': '.md', 'links_space_char': '-'
\}]
let g:zettel_options = [{'front_matter' : [['tags', '']]}]
let g:zettel_format = '%Y%m%d-%H%M-%title'
let g:vimwiki_key_mappings =
\ {
\   'all_maps': 1,
\   'global': 1,
\   'headers': 1,
\   'text_objs': 1,
\   'table_format': 0,
\   'table_mappings': 0,
\   'lists': 1,
\   'links': 1,
\   'html': 0,
\   'mouse': 0,
\ }
" Make tab into tag autocompletion
imap <Tab> <c-X><c-O>

" Yankring
" fix for yankring and neovim
let g:yankring_clipboard_monitor = 0
let g:yankring_history_dir = '~/.config/nvim/tmp/yank'
" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y
noremap <leader>p :set paste<CR>:put    *<CR>:set nopaste<CR> " Preserve indentation while pasting text from the OS X clipboard
noremap <leader>T :Tags<CR>
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

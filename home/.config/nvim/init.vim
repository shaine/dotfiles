" vim-plug
call plug#begin('~/.config/nvim/plugged')
Plug 'shaine/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'rakr/vim-one'
Plug 'dylanaraps/ryuuko'
" Plug 'dylanaraps/crayon'
" Plug 'dylanaraps/wal'

" Languages
" Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
" Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
" Plug 'othree/yajs.vim', { 'for': 'javascript' }
" Plug 'mxw/vim-jsx', { 'for': 'javascript' }
" Plug 'sheerun/vim-polyglot',
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'mboughaba/i3config.vim', { 'for': 'i3config' }
Plug 'vimwiki/vimwiki'
Plug 'elixir-editors/vim-elixir'
Plug 'sbennett33/vim-mix-format', { 'branch': 'sbennett/support-heex-templates' }

" Tools
Plug 'vim-scripts/YankRing.vim' " Yank/paste ring
Plug 'ervandew/supertab' " Auto-complete with tab
Plug 'tpope/vim-surround' " Operate with surrounds or within surrounds
Plug 'Raimondi/delimitMate' " Auto-close quotes
Plug 'tpope/vim-fugitive' " Git integration
Plug 'scrooloose/nerdtree', " File explorer
Plug 'jistr/vim-nerdtree-tabs' " NERDTree across tabs
Plug 'sjl/gundo.vim', " Undo UI
Plug 'tpope/vim-repeat' " Better . repeating
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy finder
Plug 'junegunn/fzf.vim'
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
autocmd FileType markdown setlocal wrap linebreak |
      \ setlocal autoread |
      \ autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir
autocmd FileType vimwiki,markdown setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

" Prevent vimwiki from injecting unwanted headings
autocmd VimEnter * autocmd! vimwiki BufNewFile *.md

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
nmap <silent> // :nohlsearch<CR>
" Don't jump when setting current word to search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *N
" Force redraw
nmap <leader>r :redraw!<CR>
nnoremap Q <nop>
nnoremap <Space> a_<Esc>r
command! Q q

" Copy line c ontent
nnoremap <leader>Y :normal! ^yg_<CR>

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
" let g:ale_linters_ignore = ['reek']

" Elixir
let g:mix_format_silent_errors = 1
let g:mix_format_on_save = 1

" FZF
map <Leader>s :Ag<CR>
" map <Leader>f :FZF<CR>
map <Leader>f :Files<CR>
autocmd VimEnter * if getcwd() =~ "Documents" |
      \ map <Leader>f :Ag title:<CR> |
      \ endif

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

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, '--hidden', fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Ags
  \ call fzf#vim#ag(<q-args>, '--hidden --case-sensitive', fzf#vim#with_preview(), <bang>0)

let $FZF_DEFAULT_OPTS = '-e --bind ctrl-a:select-all --bind ctrl-d:deselect-all'

" Fugitive
map <Leader>g :Git<CR>

" Gist
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

" Grep
set grepprg=ag\ --no-group\ --vimgrep
function! Grep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'

" Gundo configuration
map <Leader>u :GundoToggle<CR>
let g:gundo_prefer_python3 = 1

" NERDTree
nnoremap <silent> <leader>F :NERDTreeTabsToggle<CR>
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeAutoDeleteBuffer = 1
" let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
" Auto close when only window remaining
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Paste toggle
nnoremap <Leader>v :set invpaste paste?<CR>

" Quickfix
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

" Space.vim related
let g:space_no_second_prev_mapping = 1
let g:space_no_jump = 1
let g:space_no_section = 1
nmap <Tab> <Plug>SmartspaceNext
nmap <BS> <Plug>SmartspacePrev
nnoremap <Space> a_<Esc>r

" vimwiki
au BufNewFile ~/Documents/diary/*.md :silent 0r !~/.config/nvim/bin/generate-vimwiki-diary-template '%'
function! VimwikiLinkHandler(link)
  if a:link =~ '\.\(pdf\|jpg\|jpeg\|png\|gif\)$'
    call vimwiki#base#open_link(':e ', 'file:'.a:link)
    return 1
  endif
  return 0
endfunction

function! s:get_wiki_file(filename)
  let fileparts = split(a:filename, '\V.')
  return join(fileparts[0:-2],".")
endfunction

vmap <leader>[ <Plug>Markdown_MoveToPreviousHeader
vmap [\| <Plug>VimwikiGoToPrevHeader

function! InsertDate()
  put =strftime('%Y-%m-%d %H:%M')
endfun

function! ZettelFromTitle()
  norm Ititle: O---id: =expand('%:t')0f.DjyypOdate: :call InsertDate()k,Jo---jcf # $:w
endfun

function! Reference()
  " norm :%s/“/_“/g:%s/”/”_/g//$i>?httpi<//0yypi> kIcitation: yyojyyPr#f_xxf”hC.okyyggP^stitle:O---jf,?[A-Z]y ocitekey: :r! ~/.bin/next_reference "k,J^f l"py$f.Dodate: :call InsertDate()k,Jjo---:w ~/Documents/resources/website/references/p
  normal! :%s/“/_“/g :%s/”/”_/g //$i>?http i<//0yypi>  kIcitation:  yy o jyyPr# f_xx f”hC. o kyy ggP^stitle: O--- jf, ?[A-Z] y ocitekey: :r! ~/.bin/next_reference " k,J ^f l"py$ f.D odate: :call InsertDate()k,J jo--- :w ~/Documents/resources/website/references/p
endfun

" :%s/“/_“/g
" :%s/”/”_/g
" //$i>?http
" i<//0yypi> 
" kIcitation: 
" yy
" o
" jyyPr#
" f_xx
" f”hC.
" o
" kyy
" ggP^stitle:
" O---
" jf,
" ?[A-Z]
" y ocitekey: :r! ~/.bin/next_reference "
" k,J
" ^f l"py$
" f.D
" odate: :call InsertDate()k,J
" jo---
" :w ~/Documents/resources/website/references/p

nmap <Leader>zt :call ZettelFromTitle()<cr>

let g:vimwiki_auto_header = 1
let g:vimwiki_hl_headers = 1
let g:vimwiki_create_link = 1
let g:vimwiki_list = [{
      \'path': '~/Documents', 'syntax': 'markdown', 'ext': '.md', 'links_space_char': '-', 'auto_diary_index': 1
      \}, {
      \'path': '~/Documents/zk', 'syntax': 'markdown', 'ext': '.md', 'links_space_char': '-'
      \}, {
      \'path': '~/Documents/zk-staging', 'syntax': 'markdown', 'ext': '.md', 'links_space_char': '-'
      \}]
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
" Yank text to the clipboard
noremap <leader>y "*y
noremap <leader>yy "*yy
noremap <leader>dd "*dd
noremap <leader>p :set paste<CR>:put    *<CR>:set nopaste<CR>
noremap <leader>P :set paste<CR>:norm"+p<CR>:set nopaste<CR>
noremap <leader>T :Tags<CR>
" Paste at the end of the line
" nnoremap <Leader>P ma$p`a

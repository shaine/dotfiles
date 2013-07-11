" Setup
set nocompatible " Don't need vi compatibility
call pathogen#infect() " Start Pathogen to load bundles
call pathogen#helptags() " Pathogen to load help tags
syntax enable " Enable syntax highlighting
set encoding=utf-8 " Files should always be UTF8
filetype plugin indent on " Auto indent
au BufNewFile,BufRead *.inc set filetype=php " Explicit filetypes - PHP
au BufNewFile,BufRead *.tmux set filetype=tmux " Explicit filetypes - tmux
let mapleader = ","
nnoremap <leader>S :so ~/.vimrc<cr>

" Colorscheme
set background=light
if exists("$PANIC_PROMPT")
  " Execute this if Prompt started our session
  let g:solarized_termcolors=256
" Only use dark locally, light otherwise
elseif hostname()=="shaine.lan"
  set background=dark
endif
"let g:solarized_termtrans = 1
"let g:solarized_contrast="high"
colorscheme solarized
"call togglebg#map("<Leader>b")
highlight clear SignColumn

" Key mappings for pane selection
let g:tmux_navigator_no_mappings = 1
nmap <silent> <C-h> :TmuxNavigateLeft<cr>
nmap <silent> <C-j> :TmuxNavigateDown<cr>
nmap <silent> <C-k> :TmuxNavigateUp<cr>
nmap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap _ :sp<CR><C-w>j
nnoremap \| :vsp<CR><C-w>l
nnoremap <leader>t :tabe<CR>
" Keep the splits always equal in size
autocmd VimResized * wincmd =

" Swap word left/right
nnoremap H :let @h=@/<CR>"_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o><C-l>:let @/=@h<CR>
nnoremap L :let @l=@/<CR>"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>/\w\+\_W\+<CR><C-l>:let @/=@l<CR>
" Swap line(s) up/down
nnoremap K :m-2<CR>==
vnoremap K :m-2<CR>gv=gv
nnoremap J :m+<CR>==
vnoremap J :m'>+<CR>gv=gv

" Extra escape bindings
inoremap jj <Esc>
inoremap kk <Esc>
inoremap jk <Esc>

" Other bindings
nmap <silent> // :nohlsearch<CR>" Clear search
nmap <leader>r :redraw!<CR>" Force redraw

" Swap ` and ' for better tmux integration
nnoremap ' `
nnoremap ` '

" CtrlP
let g:ctrlp_working_path_mode = 2
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|\.DS_Store$\|\.png$\|\.jpg$\|\.gif$\|\.bak$\|\.pdf'
let g:ctrlp_map = '<Leader>f'
let g:ctrlp_show_hidden = 1
"let g:ctrlp_max_files = 200000

" Fugitive
map <Leader>g :Gstatus<CR>

" Gundo configuration
map <Leader>u :GundoToggle<CR>

" NERDTree
nnoremap <leader>F :NERDTreeTabsToggle<CR>

" Paste toggle
nnoremap <Leader>v :set invpaste paste?<CR>
set showmode

" Powerline
if exists("$PANIC_PROMPT")
  " For iPad
  let g:Powerline_symbols='unicode'
else
  let g:Powerline_symbols='fancy'
endif
let g:Powerline_colorscheme='solarized256'
let g:Powerline_stl_path_style='short'

" Space.vim related
let g:space_no_second_prev_mapping = 1
let g:space_no_jump = 1
nmap <Tab> <Plug>SmartspaceNext
nmap <BS> <Plug>SmartspacePrev
nnoremap <Space> a_<Esc>r

" Syntastic
let g:syntastic_check_on_open=1

" Tabularize configuration
nmap <Leader>aa :Tabularize<CR>
vmap <Leader>aa :Tabularize<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" Tagbar
nnoremap <leader>T :TagbarToggle<cr>
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

" Undo files
set history=1000
set undolevels=1000
set undofile
set undodir=~/.vim/tmp/undo//
set noswapfile
set nobackup
set nowb

" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR> " Preserve indentation while pasting text from the OS X clipboard
" Paste at the end of the line
nnoremap <Leader>P ma$p`a

" Yankring
let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring/'

" Zen Code
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

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

set showcmd " Show location info in lower right
set nowrap " Don't line wrap
set tabstop=4 shiftwidth=4 " Set tabs to softab 4
set expandtab " Turn tabs to spaces
set softtabstop=4 " Something else about tabs
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
set cursorline

if has("gui_running")
  set guioptions=egmrt
endif

if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  " au! BufWritePost .vimrc source %
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


" custom tab pages line with tab numbers - modified version of script by JonSkanes
" http://vim.wikia.com/index.php?title=Show_tab_number_in_your_tab_line&oldid=29439
hi Search cterm=reverse ctermfg=DarkBlue
hi Visual cterm=reverse ctermfg=DarkRed
hi TabLineFill cterm=none ctermfg=234 ctermbg=234
hi TabLine cterm=none ctermfg=245 ctermbg=236
hi TabLineSel cterm=none ctermfg=234 ctermbg=33
hi TabLineEnd cterm=none ctermfg=236 ctermbg=234
hi TabLineSelStart cterm=none ctermfg=236 ctermbg=33
hi TabLineSelEnd cterm=none ctermfg=33 ctermbg=236
hi TabLineEndSelEnd cterm=none ctermfg=33 ctermbg=234
set tabline=%!MyTabLine()
function! MyTabLine()
  let s = ''
  let t = tabpagenr()
  let i = 1
  let len = tabpagenr('$')
  while i <= len
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%#TabLine#'
    if i != 1
      if i == t
        let s .= ' %#TabLineSelStart#⮀'
      elseif i-1 != t
        let s .= ' ⮁'
      endif
    endif
    let s .= (i == t ? '%#TabLineSel# ' : '%#TabLine# ')
    " set the tab page number (for mouse clicks)
    let s .= '%' . i . 'T'
    " set page number string
    let s .=  i . ' '
    if i == t
      let s .= '⮁ '
    endif
    let m = 0 " &modified counter
    let bufnr = buflist[winnr - 1]
    let file = bufname(bufnr)
    let buftype = getbufvar(bufnr, 'buftype')
    if buftype == 'nofile'
      if file =~ '\/.'
        let file = substitute(file, '.*\/\ze.', '', '')
      endif
    else
      let file = fnamemodify(file, ':p:t')
    endif
    if file == ''
      let file = '[No Name]'
    endif
    for b in buflist
      " check and ++ tab's &modified count
      if getbufvar( b, "&modified" )
        let m += 1
      endif
    endfor
    if m > 0
      let s.= '[+]'
    endif
    let s .= file
    if i == t
      if i == len
        let s .= ' %#TabLineEndSelEnd#⮀'
      else
        let s .= ' %#TabLineSelEnd#⮀'
      endif
    endif
    let i = i + 1
  endwhile
  if i-1 != t
    let s .= ' %#TabLineEnd#⮀'
  endif
  let s .= '%T%#TabLineFill#%='
  let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return s
endfunction

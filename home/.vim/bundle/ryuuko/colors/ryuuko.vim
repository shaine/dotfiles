
" ryuuko.vim -- Vim color scheme.
" Author:      dyl ()
" Webpage:
" Description:

hi clear

set background=dark

if exists("syntax_on")
syntax reset
endif

let colors_name = "ryuuko"
let g:colors_name = "ryuuko"

" highlight groups {{{

    hi Normal ctermbg=0 ctermfg=7 cterm=NONE guibg=#434e4a guifg=#f0e4d8 gui=NONE
set background=dark
    hi NonText ctermbg=NONE ctermfg=0 cterm=NONE guibg=NONE guifg=#434e4a gui=NONE
    hi Comment ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi Constant ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi Error ctermbg=1 ctermfg=7 cterm=NONE guibg=#99736e guifg=#f0e4d8 gui=NONE
    hi Identifier ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#99736e gui=NONE
    hi Ignore ctermbg=8 ctermfg=0 cterm=NONE guibg=#70838c guifg=#434e4a gui=NONE
    hi PreProc ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi Special ctermbg=NONE ctermfg=6 cterm=NONE guibg=NONE guifg=#8fb3ad gui=NONE
    hi Statement ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#99736e gui=NONE
    hi String ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
    hi Number ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi Todo ctermbg=8 ctermfg=3 cterm=NONE guibg=#70838c guifg=#bfb7a1 gui=NONE
    hi Type ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi Underlined ctermbg=NONE ctermfg=1 cterm=underline guibg=NONE guifg=#99736e gui=underline
    hi StatusLine ctermbg=0 ctermfg=8 cterm=NONE guibg=#434e4a guifg=#70838c gui=NONE
    hi StatusLineNC ctermbg=NONE ctermfg=0 cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi TabLine ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi TabLineFill ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi TabLineSel ctermbg=4 ctermfg=0 cterm=NONE guibg=#7c9fa6 guifg=#434e4a gui=NONE
    hi TermCursorNC ctermbg=3 ctermfg=0 cterm=NONE guibg=#bfb7a1 guifg=#434e4a gui=NONE
    hi VertSplit ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi Title ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi CursorLine ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi LineNr ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi CursorLineNr ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi helpLeadBlank ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi helpNormal ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi VisualNOS ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#99736e gui=NONE
    hi Pmenu ctermbg=8 ctermfg=7 cterm=NONE guibg=#70838c guifg=#f0e4d8 gui=NONE
    hi PmenuSbar ctermbg=6 ctermfg=7 cterm=NONE guibg=#8fb3ad guifg=#f0e4d8 gui=NONE
    hi PmenuSel ctermbg=4 ctermfg=0 cterm=NONE guibg=#7c9fa6 guifg=#434e4a gui=NONE
    hi PmenuThumb ctermbg=8 ctermfg=8 cterm=NONE guibg=#70838c guifg=#70838c gui=NONE
    hi FoldColumn ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi Folded ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi WildMenu ctermbg=2 ctermfg=0 cterm=NONE guibg=#78a090 guifg=#434e4a gui=NONE
    hi SpecialKey ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi DiffAdd ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
    hi DiffChange ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi DiffDelete ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#99736e gui=NONE
    hi DiffText ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi IncSearch ctermbg=3 ctermfg=0 cterm=NONE guibg=#bfb7a1 guifg=#434e4a gui=NONE
    hi Directory ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi MatchParen ctermbg=8 ctermfg=0 cterm=NONE guibg=#70838c guifg=#434e4a gui=NONE
    hi signColumn ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi ErrorMsg ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi ModeMsg ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
    hi MoreMsg ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
    hi Question ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi WarningMsg ctermbg=1 ctermfg=0 cterm=NONE guibg=#99736e guifg=#434e4a gui=NONE
    hi Structure ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi CursorColumn ctermbg=8 ctermfg=7 cterm=NONE guibg=#70838c guifg=#f0e4d8 gui=NONE
    hi ModeMsg ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi SpellBad ctermbg=NONE ctermfg=1 cterm=underline guibg=NONE guifg=#99736e gui=underline guisp=#99736e
    hi SpellCap ctermbg=NONE ctermfg=4 cterm=underline guibg=NONE guifg=#7c9fa6 gui=underline guisp=#7c9fa6
    hi SpellLocal ctermbg=NONE ctermfg=5 cterm=underline guibg=NONE guifg=#ccad99 gui=underline guisp=#ccad99
    hi SpellRare ctermbg=NONE ctermfg=6 cterm=underline guibg=NONE guifg=#8fb3ad gui=underline guisp=#8fb3ad
    hi Boolean ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi Character ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#99736e gui=NONE
    hi Conditional ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi Define ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi Delimiter ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi Float ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi Include ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi Keyword ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi Label ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi Operator ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi Repeat ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi SpecialChar ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi Tag ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi Typedef ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi vimUserCommand ctermbg=NONE ctermfg=1 cterm=BOLD guibg=NONE guifg=#99736e gui=BOLD
        hi link vimMap vimUserCommand
        hi link vimLet vimUserCommand
        hi link vimCommand vimUserCommand
        hi link vimFTCmd vimUserCommand
        hi link vimAutoCmd vimUserCommand
        hi link vimNotFunc vimUserCommand
    hi vimNotation ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi vimMapModKey ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi vimBracket ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi vimCommentString ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi htmlLink ctermbg=NONE ctermfg=1 cterm=underline guibg=NONE guifg=#99736e gui=underline
    hi htmlBold ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi htmlItalic ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi htmlEndTag ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi htmlTag ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi htmlTagName ctermbg=NONE ctermfg=1 cterm=BOLD guibg=NONE guifg=#99736e gui=BOLD
    hi htmlH1 ctermbg=NONE ctermfg=7 cterm=BOLD guibg=NONE guifg=#f0e4d8 gui=BOLD
        hi link htmlH2 htmlH1
        hi link htmlH3 htmlH1
        hi link htmlH4 htmlH1
        hi link htmlH5 htmlH1
        hi link htmlH6 htmlH1
    hi cssMultiColumnAttr ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
        hi link cssFontAttr cssMultiColumnAttr
        hi link cssFlexibleBoxAttr cssMultiColumnAttr
    hi cssBraces ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
        hi link cssAttrComma cssBraces
    hi cssValueLength ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi cssUnitDecorators ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi cssValueNumber ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
        hi link cssValueLength cssValueNumber
    hi cssNoise ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi cssTagName ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#99736e gui=NONE
    hi cssFunctionName ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi scssSelectorChar ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi scssAttribute ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
        hi link scssDefinition cssNoise
    hi sassidChar ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#99736e gui=NONE
    hi sassClassChar ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi sassInclude ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi sassMixing ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi sassMixinName ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi javaScript ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi javaScriptBraces ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi javaScriptNumber ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi markdownAutomaticLink ctermbg=NONE ctermfg=1 cterm=underline guibg=NONE guifg=#99736e gui=underline
        hi link markdownUrl markdownAutomaticLink
    hi markdownError ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi markdownCode ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi markdownCodeBlock ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi markdownCodeDelimiter ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi xdefaultsValue ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi rubyInclude ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi rubyDefine ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi rubyFunction ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi rubyStringDelimiter ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
    hi rubyInteger ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi rubyAttribute ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi rubyConstant ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi rubyInterpolation ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
    hi rubyInterpolationDelimiter ctermbg=NONE ctermfg=3 cterm=NONE guibg=NONE guifg=#bfb7a1 gui=NONE
    hi rubyRegexp ctermbg=NONE ctermfg=6 cterm=NONE guibg=NONE guifg=#8fb3ad gui=NONE
    hi rubySymbol ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
    hi rubyTodo ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#70838c gui=NONE
    hi rubyRegexpAnchor ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
        hi link rubyRegexpQuantifier rubyRegexpAnchor
    hi pythonOperator ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi pythonFunction ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi pythonRepeat ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi pythonStatement ctermbg=NONE ctermfg=1 cterm=Bold guibg=NONE guifg=#99736e gui=Bold
    hi pythonBuiltIn ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi phpMemberSelector ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi phpComparison ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi phpParent ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE
    hi cOperator ctermbg=NONE ctermfg=6 cterm=NONE guibg=NONE guifg=#8fb3ad gui=NONE
    hi cPreCondit ctermbg=NONE ctermfg=5 cterm=NONE guibg=NONE guifg=#ccad99 gui=NONE
    hi SignifySignAdd ctermbg=NONE ctermfg=2 cterm=NONE guibg=NONE guifg=#78a090 gui=NONE
    hi SignifySignChange ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi SignifySignDelete ctermbg=NONE ctermfg=1 cterm=NONE guibg=NONE guifg=#99736e gui=NONE
    hi NERDTreeDirSlash ctermbg=NONE ctermfg=4 cterm=NONE guibg=NONE guifg=#7c9fa6 gui=NONE
    hi NERDTreeExecFile ctermbg=NONE ctermfg=7 cterm=NONE guibg=NONE guifg=#f0e4d8 gui=NONE

    hi Search cterm=reverse ctermfg=DarkBlue
    hi Visual cterm=reverse ctermfg=DarkRed
    hi Cursor ctermfg=0 ctermbg=15
    hi CursorLine ctermbg=NONE ctermbg=237 ctermfg=NONE
    hi ColorColumn ctermbg=237 ctermfg=NONE cterm=NONE

" Generated with RNB (https://gist.github.com/romainl/5cd2f4ec222805f49eca)

" }}}

" Neovim Terminal Mode Colors
let g:terminal_color_0 = "#434e4a"
let g:terminal_color_1 = "#99736e"
let g:terminal_color_2 = "#78a090"
let g:terminal_color_3 = "#bfb7a1"
let g:terminal_color_4 = "#7c9fa6"
let g:terminal_color_5 = "#ccad99"
let g:terminal_color_6 = "#8fb3ad"
let g:terminal_color_7 = "#f0e4d8"
let g:terminal_color_8 = "#70838c"
let g:terminal_color_9 = "#99736e"
let g:terminal_color_10 = "#78a090"
let g:terminal_color_11 = "#bfb7a1"
let g:terminal_color_12 = "#7c9fa6"
let g:terminal_color_13 = "#ccad99"
let g:terminal_color_14 = "#8fb3ad"
let g:terminal_color_15 = "#f0e4d8"

" }}}

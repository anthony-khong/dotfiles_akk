" Inspired by vim-monochrome

set background=dark

hi clear
if exists('syntax_on')
   syntax reset
endif

let g:colors_name = 'monochrome'

" These commands are generated, see bin/generate.rb.
hi Normal                   ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi Cursor                   ctermfg=16  ctermbg=252  cterm=NONE      term=NONE
hi CursorLine               ctermfg=252 ctermbg=234  cterm=NONE      term=NONE
hi CursorLineNr             ctermfg=15  ctermbg=none cterm=bold      term=bold
hi ColorColumn              ctermfg=252 ctermbg=234  cterm=NONE      term=NONE
hi FoldColumn               ctermfg=248 ctermbg=none cterm=NONE      term=NONE
hi Folded                   ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi LineNr                   ctermfg=248 ctermbg=none cterm=NONE      term=NONE
hi Statement                ctermfg=15  ctermbg=none cterm=bold      term=bold
hi PreProc                  ctermfg=15  ctermbg=none cterm=bold      term=bold
hi String                   ctermfg=67  ctermbg=none cterm=NONE      term=NONE
hi Comment                  ctermfg=243 ctermbg=none cterm=NONE      term=NONE
hi Constant                 ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi Type                     ctermfg=15  ctermbg=none cterm=bold      term=bold
hi Function                 ctermfg=252 ctermbg=none cterm=bold      term=bold
hi Identifier               ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi Special                  ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi MatchParen               ctermfg=252  ctermbg=74  cterm=NONE      term=NONE
hi Search                   ctermfg=15  ctermbg=67   cterm=NONE      term=NONE
hi Visual                   ctermfg=15  ctermbg=67   cterm=NONE      term=NONE
hi NonText                  ctermfg=248 ctermbg=none cterm=NONE      term=NONE
hi Directory                ctermfg=15  ctermbg=none cterm=bold      term=bold
hi Title                    ctermfg=15  ctermbg=none cterm=bold      term=bold
hi markdownHeadingDelimiter ctermfg=15  ctermbg=none cterm=bold      term=bold
hi markdownHeadingRule      ctermfg=15  ctermbg=none cterm=bold      term=bold
hi markdownLinkText         ctermfg=67  ctermbg=none cterm=underline term=underline
hi Todo                     ctermfg=16  ctermbg=226  cterm=bold      term=bold
hi Pmenu                    ctermfg=15  ctermbg=67   cterm=NONE      term=NONE
hi PmenuSel                 ctermfg=67  ctermbg=15   cterm=NONE      term=NONE
hi helpSpecial              ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi helpHyperTextJump        ctermfg=67  ctermbg=none cterm=underline term=underline
hi helpNote                 ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimOption                ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimGroup                 ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimHiClear               ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimHiGroup               ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimHiAttrib              ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimHiGui                 ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimHiGuiFgBg             ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimHiCTerm               ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimHiCTermFgBg           ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimSynType               ctermfg=252 ctermbg=none cterm=NONE      term=NONE
hi vimCommentTitle          ctermfg=243 ctermbg=none cterm=NONE      term=NONE

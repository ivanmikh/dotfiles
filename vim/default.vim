" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "default"

" Set transparent background
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
" Set some colors
hi LineNr       ctermfg=grey      guifg=grey
hi CursorLineNr ctermfg=grey      guifg=white
hi NonText      ctermfg=darkgrey  guifg=#3d3b3b
hi Statement    ctermfg=grey      guifg=#b2b2b2
hi Type         ctermfg=darkgreen guifg=seagreen 
hi Comment      ctermfg=gray      guifg=gray
hi Identifier   ctermfg=darkcyan  guifg=darkcyan
hi Search       ctermfg=NONE      guifg=NONE
hi Search       ctermbg=green     guibg=green
hi IncSearch    ctermfg=NONE      guifg=NONE
hi IncSearch    ctermbg=green     guibg=green
" vim: sw=2

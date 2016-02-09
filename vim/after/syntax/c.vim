" [tah] just tweak a few things in C
"
"TODO
"
"can i make more generic tweaks by manipulating the generic categories
" PreCondit Statement
"
" make stuff really stand out
"
" #if #ifdef #ifndef #endif         cPreCondit -> PreCondit
highlight cPreCondit ctermfg=Red guifg=Red
"
" goto break return continue asm    cStatement -> Statement
highlight cStatement ctermfg=Red guifg=Red
"
" TODO: make exit() special, make final return in a function not special
if exists("+colorcolumn")
    set colorcolumn=80
endif

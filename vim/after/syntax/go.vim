" [tah] adapted from C tweaks
"
"TODO
"
"can i make more generic tweaks by manipulating the generic categories
"
" make transfers of control really stand out
"
" TODO the following statement treats fallthrough as a transfer of control
" but shouldn't
highlight goStatement ctermfg=Red guifg=Red
"
" TODO: does golang have an exit() equivalent?  make it and any
"       last-line 'return's in a function not special
if exists("+colorcolumn")
    set colorcolumn=80
endif

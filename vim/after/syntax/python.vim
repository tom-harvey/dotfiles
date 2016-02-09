" [tah] just tweak a few things in python
"
" make stuff really stand out
"TODO can i generalize this type of tweak across languages?
"TODO don't highlight return in last line of function
"
syn keyword pythonJump  break continue return
highlight pythonJump ctermfg=Red guifg=Red
"
if exists("+colorcolumn")
    set colorcolumn=80
endif

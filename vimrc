" An example for a vimrc file.
"   vi:sw=2 ts=2
"
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  " set hlsearch   " [tah] no, don't turn this on--it sux
 
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
  " trying to get my MatchParen behavior after loading a colorscheme
  " but it doesn't work
  "autocmd ColorScheme highlight MatchParen cterm=underline ctermbg=none ctermfg=none 

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" [tah] above this is largely the stock .vimrc

" use vim-plug to manage plug-ins
"  :PlugInstall   installs plugins
"  :PlugUpgrade   upgrades vim-plug itself
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
call plug#end()

" debug! this isn't "taking" below
colorscheme beauty256 

"
" [tah] for some reason, modelines is getting set to 0 on im even though 
" it defaults to 5 when .vimrc is bypassed
" set modelines=2
"
"I use mapleader as ',' sign, fast to reach and not so bad.
let mapleader=','
let g:mapleader=','

if &diff

" suggested for help with vimdiff 3-wa merge
"  map <leader>1 :diffget LOCAL<CR>
"  map <leader>2 :diffget BASE<CR>
"  map <leader>3 :diffget REMOTE<CR>
  map <leader>q :qall<CR>

" hints for improving vimdiff color scheme
"
" colorscheme XXXX
"
" OR touch up the existing:
"
" highlight DiffChange cterm=none ctermfg=black ctermbg=LightGreen gui=none guifg=bg guibg=LightGreen
" highlight DiffText   cterm=none ctermfg=black ctermbg=Red        gui=none guifg=bg guibg=Red
"
" web note: 'As far as I know, there are usually four highlight groups
" relative to diff'ing: DiffAdd, DiffChange, DiffDelete, and DiffText.'
"
" [random web note:]
" highlight DiffAdd    cterm=NONE ctermfg=bg ctermbg=Green   gui=NONE guifg=bg guibg=Green
" highlight DiffDelete cterm=NONE ctermfg=bg ctermbg=Red     gui=NONE guifg=bg guibg=Red
" highlight DiffChange cterm=NONE ctermfg=bg ctermbg=Yellow  gui=NONE guifg=bg guibg=Yellow
" highlight DiffText   cterm=NONE ctermfg=bg ctermbg=Magenta gui=NONE guifg=bg guibg=Magenta
"
" [tah] might need bang in highlight! to override
"
endif

" TODO figure out when to use map, nmap, etc.
"format paragraph
map <leader>f gq}``
map <leader>c a(* 
" TODO move sml comment start to ??
" TODO use the smoother way to get the word under the cursor, or just use
" the cscope way
"map <leader>l yaw<c-w><c-n>:r!lookfor <c-r>"<cr>
function VarExists(var, val)
    if exists(a:var) | return a:val | else | return '' | endif
endfunction

if has("cscope")
  "set cscopeprg=cscope
  set cscopetagorder=0 " search cscope db then tags
  set cscopetag
  set nocscopeverbose
  if filereadable("cscope.out") " add any database in current directory
      cs add cscope.out
  elseif $CSCOPE_DB != "" " else add database pointed to by environment
      cs add $CSCOPE_DB
  endif
  set cscopeverbose
  "find caller functions :cs find c
  "find called functions :cs find d
  "find definition       :cs find d
  nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <leader>/ :cs find t <C-R>=expand("<cword>")<CR><CR>
endif

"this quickly gets tiring
"let c_space_errors = 1
"
let g:load_doxygen_syntax=1
if &t_Co > 2 || has("gui_running")

  "-----------------
"    if has('gui_running')
"        set background=light
"    else
"        set background=dark
"    endif
  "------------------------------------------------
"   colorscheme solarized
"   g:solarized_termcolors=256 " 16 default
"   g:solarized_termtrans =1   "  0 default
"   g:solarized_degrade   =1   "  0 default
"   g:solarized_bold      =0   "  1 default
"   g:solarized_underline =0   "  1 default
"   g:solarized_italic    =0   "  1 default
"   g:solarized_contrast  ="high" or "low" "normal" default
"   g:solarized_contrast="high"
"   g:solarized_visibility="high" or "low" "normal" default
"   set g:solarized_visibility="high"
"------------------------------------------------

  if &t_Co > 16 || has("gui_running")
    colorscheme beauty256
    "colorscheme ir_black
    "colorscheme softlight
    "colorscheme bog
    "colorscheme kaltex  " BAD this one screws up editor operation!
    "----lucius stuff----
    "let g:lucius_style='light' " 'dark', or 'dark_dim'
    let g:lucius_style='dark' " 'dark', or 'dark_dim'
    "Once the color scheme is loaded, you can use the commands "LuciusLight", "LuciusDark", or
    " "LuciusDarkDim" to change schemes quickly. 
    "colorscheme lucius
    "--------------------
    "colorscheme grb256
    "colorscheme greens
    "colorscheme inkpot
    "colorscheme vividchalk
    "colorscheme jellybeans
    "colorscheme khaki
    "--------------------
    " peaksea works light and dark:
    "set background=light
    " set background=dark
    "colorscheme peaksea
    "--------------------
    "colorscheme railscasts
    "colorscheme sienna
    "colorscheme wombat256mod
    "colorscheme xoria256
    if has("gui_running") " or could just put this in .gvim
      "colorscheme pyte
    endif
  else
    "xterm16 is good below 256 colors
    "-----xterm16 stuff-----
    " Select colormap: 'soft', 'softlight', 'standard' or 'allblue'
    let xterm16_colormap    = 'allblue'
    "let xterm16_colormap    = 'standard'
    "let xterm16_colormap    = 'softlight'
    "let xterm16_colormap    = 'soft'
    "
    " Select brightness: 'low', 'med', 'high', 'default' or custom levels.
      let xterm16_brightness  = 'high'
      colorscheme xterm16
    "-----------------------
  endif
  "
  " highlight the matching paren with an underline [tah]
  " TODO needs to be after colorscheme command, 
  " would be better as an autocmd on colorscheme event
  " maybe it is a bit too subtle with the underlines...
  " highlight MatchParen cterm=underline ctermbg=none ctermfg=none 
endif

" [tah] MOREWORK put the following in .exrc if vi-lega
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" some old customizations of mine that are currently disabled
"if has("autocmd")
"  autocmd BufNewFile,BufRead *.html so    $HOME/share/tom_html.vim
"  autocmd BufNewFile         *.html read  $HOME/share/template.html
"endif
"
" .vimrc ideas: http://vi-improved.org/vimrc.html
" http://news.ycombinator.com/item?id=856051
" http://stackoverflow.com/questions/1840862/favorite-minimalistic-vimrc-configuration
"
" [idea from leetless.de (only works on real tabs--use plugin otherwise :]
" Display <tab>s etc...
"set list
" Some cool display variants for tabs (which will almost certainly break if
" your gvim/terminal is not unicode-aware).
" If you want to make your own I recommend look up the unicode table 2500 on
" the web (or any other that includes your desired characters).
" Inserting the unicode character 2500 is done by pressing: Ctrl-V Ctrl-U 2500

" Depending on your encoding the following lines might be broken for you, in
" that case try to view this in utf-8 encoding or just make your own lcs
" string as described above.


"set lcs=tab:│\ ,trail:·,extends:>,precedes:<,nbsp:&
"set lcs=tab:└─,trail:·,extends:>,precedes:<,nbsp:&
"set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&
"
"if exists("Tlist_Use_Right_Window")
    let Tlist_Use_Right_Window = 1
    "taglist toggle
    map <leader>t :TlistToggle<CR>
"endif

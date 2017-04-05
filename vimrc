" Modeline and Notes {
" vim: set sw=2 ts=2 tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:
" An example for a vimrc file.
"
"
" TODO much more cleanup needed.
" TODO can i move after/syntax stuff into here?
" } Modeline and Notes
"
" Example vimrc File from Distribution {
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2015 Mar 24
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

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif
" } end vimrc example file
"
" General {
  set mouse=a       " enable mouse usage
  set mousehide
  filetype plugin indent on
  syntax on
" } end general
"
" Plugin Management {

" use vim-plug to manage plug-ins
"  :PlugInstall   installs plugins
"  :PlugUpgrade   upgrades vim-plug itself
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'

" python folding
" seems buggy -
"Plug 'tmhedberg/SimpylFold' 

"colorschemes
Plug 'jonathanfilip/vim-lucius'
Plug 'vim-scripts/xterm16.vim'
Plug 'adampasz/stonewashed-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'romainl/flattened'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
call plug#end()

" } end Plugin Management

"
"I use mapleader as ',' sign, fast to reach and not so bad.
let mapleader=','
let g:mapleader=','


" Diff Items {
if &diff

" suggested for help with vimdiff 3-wa merge
"  map <leader>1 :diffget LOCAL<CR>
"  map <leader>2 :diffget BASE<CR>
"  map <leader>3 :diffget REMOTE<CR>
  map <leader>q :qall<CR>

" hints for improving vimdiff color scheme
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

" } end Diff Items

" TODO figure out when to use map, nmap, etc.
"format paragraph
map <leader>f gq}``
map <leader>c a(* 

" TODO use the smoother way to get the word under the cursor, or just use
" the cscope way
"map <leader>l yaw<c-w><c-n>:r!lookfor <c-r>"<cr>
function VarExists(var, val)
    if exists(a:var) | return a:val | else | return '' | endif
endfunction

"
let g:load_doxygen_syntax=1

" VIM UI {
"   Colorschemes {
"
"     historically interesting colorschemes:"
"       ir_black softlight bog grb256 greens inkpot vividchalk jellybeans
"       khaki peaksea railscasts sienna wombat256mod xoria256
"
"if has("termguicolors") " truecolor
"  set termguicolors
"endif

function! GoSolarized()
  "------------------------------------------------
  " g:solarized_termcolors=256 " 16 default
  " g:solarized_termtrans =1   "  0 default
  " g:solarized_degrade   =1   "  0 default
  " g:solarized_underline =0   "  1 default
  " g:solarized_contrast  ="high" or "low" "normal" default
  " g:solarized_contrast="high"
  " g:solarized_visibility="high" or "low" "normal" default
  " g:solarized_visibility="high"
  "------------------------------------------------
  if !has("gui_running")
    let g:solarized_bold      =0   "  1 default
    let g:solarized_italic    =0   "  1 default
  endif
  set background=dark
  syntax enable
  colorscheme solarized
endfunction

function! GoLucius()
  "----lucius stuff----
  "let g:lucius_style='light' " 'dark', or 'dark_dim'
  "commands "LuciusLight", "LuciusDark", or "LuciusDarkDim"
  syntax enable
  let g:lucius_style='dark'
  colorscheme lucius
endfunction

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ Medium\ 14,Anonymous\ Pro\ 14,Source\ Code\ Pro\ Medium\ 14
  elseif has("gui_win32")
    "take the default for now
  else "the form that MacVim wants:"
    set guifont=Anonymous\ Pro:h16,Source\ Code\ Pro:h16,Consolas:h16,Inconsolata\ Medium:h16
  endif
  call GoSolarized()
elseif &t_Co > 16
  call GoSolarized()
elseif &t_Co > 2
  call GoSolarized()

  "if &t_Co > 16 || has("gui_running")
  "else
    "xterm16 is good below 256 colors
    "-----xterm16 stuff-----
    "  http://www.math.cmu.edu/~gautam/per/opensource/xterm16/xterm16-doc.html
    " Select colormap: 'soft', 'softlight', 'standard' or 'allblue'
    "let xterm16_colormap    = 'allblue'
    "let xterm16_colormap    = 'standard'
    "let xterm16_colormap    = 'softlight'
    "let xterm16_colormap    = 'soft'
    "
    " Select brightness: 'low', 'med', 'high', 'default' or custom levels.
    " let xterm16_brightness  = 'high'
    " colorscheme xterm16
    "-----------------------
  "endif
endif
" }  end Colorschemes
"
"
" highlight the matching paren with an underline [tah]
" TODO needs to be after colorscheme command, 
" would be better as an autocmd on colorscheme event
" maybe it is a bit too subtle with the underlines...
" highlight MatchParen cterm=underline ctermbg=none ctermfg=none 
" } end VIM UI
"
" Formatting {
" [tah] MOREWORK put the following in .exrc if vi-lega
set nowrap
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" } end Formatting


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
" Plugin and Feature Configurations {
"
" taglist: http://vim-taglist.sourceforge.net/index.html
"if exists("Tlist_Use_Right_Window")
  let Tlist_Use_Right_Window = 1
  "taglist toggle
  map <leader>t :TlistToggle<CR>
"endif "taglist

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
endif "cscope

"this quickly gets tiring
"let c_space_errors = 1
" } end Plugin Configurations
"

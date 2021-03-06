" Modeline and Notes {
" vim: set sw=2 ts=2 tw=78 
" TODO add foldmarker={,} foldlevel=0 foldmethod=marker:
" TODO much more cleanup needed.
" TODO can i move after/syntax stuff into here?
" } Modeline and Notes
"
" taken from Distribution Example vimrc File {
set nocompatible                " This must be first
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set nobackup		                " do not keep a backup file
set ruler		                    " show the cursor position all the time
set showcmd		                  " display incomplete commands
set incsearch		                " do incremental searching

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
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <leader>i <Plug>(go-info)
  autocmd FileType go nmap <leader>l <Plug>(go-lint)
  autocmd FileType go nmap <leader>m <Plug>(go-metalinter)
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <leader>t <Plug>(go-test)
  autocmd FileType go nmap <leader>v <Plug>(go-vet)

  autocmd FileType text setlocal textwidth=78
  " When editing a file, always jump to the last known cursor position.
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
  " bce (background color erase) workaround--gnome terminal not doing well
  " without this when xterm-256color on unbuntu 17.04
  set t_ut=         
" } end general
"
" Plugin Management {

" use vim-plug to manage plug-ins
"  :PlugInstall   installs plugins
"  :PlugUpgrade   upgrades vim-plug itself
"
call plug#begin('~/.vim/plugged')

"Language syntax
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
"turn on near-max amount of syntax highlighting for now
"TODO turn some of these off after a while
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1 
let g:go_highlight_format_strings = 1
Plug 'cespare/vim-toml' 
Plug 'petRUShka/vim-opencl'
Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1
" python folding
" seems buggy -
"Plug 'tmhedberg/SimpylFold' 

"colorschemes
"Plug 'vim-scripts/xterm16.vim'
Plug 'adampasz/stonewashed-themes'
Plug 'romainl/flattened'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'rakr/vim-one'
call plug#end()

" } end Plugin Management

let mapleader=','
let g:mapleader=','

" Diff Items {
if &diff
  let g:solarized_diffmode="high"
  if has("gui_running")
    "try for wide screen"
    set columns=170
  endif
" TODO web suggests reducing syntax coloring while in diff mode to make diff
" coloring easier to see
"
" suggested for help with vimdiff 3-wa merge
"  map <leader>1 :diffget LOCAL<CR>
"  map <leader>2 :diffget BASE<CR>
"  map <leader>3 :diffget REMOTE<CR>
  map <leader>q :qall<CR>
endif
" } end Diff Items

" TODO figure out when to use map, nmap, etc.
"format paragraph
map <leader>f gq}``
map <leader>c a(* 

" TODO use the smoother way to get the word under the cursor, or just use
" the cscope way
"map <leader>l yaw<c-w><c-n>:r!lookfor <c-r>"<cr>
"function VarExists(var, val)
"    if exists(a:var) | return a:val | else | return '' | endif
"endfunction

let g:load_doxygen_syntax=1

" VIM UI {
"   Colorschemes {
"
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" "see :help xterm-true-color
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"if $XTERM =~ ".*italic.*"
let g:has_italics=0
if has("gui_running") || &t_ZH == "\<Esc>[3m" 
    let g:has_italics=1
endif

function! GoSolarized()
  if g:has_italics
    let g:solarized_term_italics=1
  endif
  set background=dark "or light
  colorscheme solarized8
endfunction

function! GoGruvbox()
  set background=dark
  if g:has_italics
    let g:gruvbox_italic=1
  endif
  colorscheme gruvbox
endfunction

function! GoPalenight()
  if g:has_italics
    let g:palenight_terminal_italics=1
  endif
  colorscheme palenight
endfunction

function! GoOne()
  set background=dark "or light
  if g:has_italics
    let g:one_allow_italics=1
  endif
  colorscheme one
endfunction

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ Medium\ 14,Anonymous\ Pro\ 14,Source\ Code\ Pro\ Medium\ 14
  elseif has("gui_win32")
    "take the default for now
  else "the form that MacVim wants:"
    set guifont=Anonymous\ Pro:h16,Source\ Code\ Pro:h16,Consolas:h16,Inconsolata\ Medium:h16
  endif
  call GoOne()
elseif &t_Co > 16
  call GoOne()
elseif &t_Co > 2
  call GoOne()

endif
" TODO was not working on az, what's the status now?
if has("autocmd")
  augroup vimrc
    autocmd!
    "autocmd ColorScheme * highlight Comment cterm=italic
    if has("colorcolumn")
      autocmd ColorScheme * set colorcolumn=80
      "highlight ColorColumn ctermbg=0 guibg=lightgrey
    endif
    " highlight the matching paren with an underline [tah]
    " maybe it is a bit too subtle with the underlines...
    " highlight MatchParen cterm=underline ctermbg=none ctermfg=none 
  endif
" }  end Colorschemes
"
"
" } end VIM UI
"
" Formatting {
" [tah] MOREWORK put the following in .exrc if vi-lega
"set nowrap
if has("showbreak")
    set showbreak=↪
endif
if has("breakindent")
    set breakindent
endif
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" } end Formatting


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

PATH=$HOME/bin:/bin:$HOME/bin/sh:/Volumes/tah/bin:$HOME/bin/py:/usr/local/bin:/usr/local/sbin:$PATH:
# for std golang add /usr/local/go/bin
# for homebrew go (golang):
#   don't add: export GOROOT=/usr/local/opt/go
#   maybe add: PATH=$PATH:/usr/local/opt/go/libexec/libexec/bin
# for any go installation:
export GOPATH=$HOME/p/go
PATH=$PATH/$GOPATH/bin
# for scala add /usr/local/scala/sbt/bin
# for sml add   /usr/local/smlnj/bin
# for racket add /usr/local/racket/bin
# for pkgsrc: /usr/pkg/bin:/usr/pkg/sbin:
export PATH


# MOREWORK: add VISUAL
EDITOR=vi; export EDITOR
VISUAL=$EDITOR; export VISUAL # this might help git, ?others?
PAGER="less -X" ; export PAGER
LANG=en_US.UTF-8 ; export LANG   # this helps mutt display 8-bit chars

# applescript shortcuts from "Using Python and Applescript Together"
alias ose='open /Applications/AppleScript/Script\ Editor.app/'
export OSA='osascript -e '
export SE='"Script Editor"'
alias cse='$OSA "tell app $SE to quit"'

# shortcuts only for interactive
alias we=weight
alias py=python3

# gives color output for ls
CLICOLOR=on ; export CLICOLOR
XTIDE_DEFAULT_LOCATION="La Jolla" ; export XTIDE_DEFAULT_LOCATION

# let's turn this off after tiger upgrade to see if it is still needed
# yes, it is
## tah: helps inside of "dc":
## tah: in Terminal app, option "del sends backspace" is checked
stty erase "^H"

umask 2

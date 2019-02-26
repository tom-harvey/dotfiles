# ~/.profile 
# vim: set filetype=sh:
#
# should be compatible with all near-POSIX shells sh, ksh, dash, bash, etc.
# MAY be sourced from ~/.bash_profile (i do this), once per login
# WILL be run from sh, once per login
# contains items that can be inherited by interactive and non-interactive 
# subshells
#
# debug shell startup
#DS="$HOME/dbg_start" && [ -w "$DS" ] && echo .profile "$(date '+%T.%N')" >> "$DS"
#
export GOPATH=$HOME/p/go
#
mypath=$HOME/bin:$HOME/tah/bin:$GOPATH/bin:/usr/local/bin:/usr/local/sbin
addif="/usr/pkg/bin /usr/local/go/bin /usr/pkg/go/bin"
# for scala add /usr/local/scala/sbt/bin
# for sml add   /usr/local/smlnj/bin
# for racket add /usr/local/racket/bin
for d in $addif; do
    [ -r "$d" ] && mypath=$mypath:$d
done
PATH=$mypath:$PATH:
export PATH
#
[ -r "$HOME/.shrc" ] && export ENV=$HOME/.shrc
umask 2

# ~/.profile 
# vim: set filetype=sh:
#
# should be compatible with all near-POSIX shells sh, ksh, dash, bash, etc.
# MAY be sourced from ~/.bash_profile (i do this), once per login
# WILL be run from sh, once per login
# contains items that can be inherited by interactive and non-interactive 
# subshells
#     environment variable definitions
DS="$HOME/dbg_start" && [ -w "$DS" ] && echo .profile "$(date '+%T.%N')" >> "$DS" # TODO debug
PATH=$HOME/bin:/bin:$HOME/bin/sh:/Volumes/tah/bin:$HOME/bin/py:/usr/local/bin:/usr/local/sbin:$PATH:
# for homebrew go (golang):
#   don't add: export GOROOT=/usr/local/opt/go
#   maybe add: PATH=$PATH:/usr/local/opt/go/libexec/libexec/bin
# for any go installation:
GOBIN=/usr/local/go/bin && [ -d $GOBIN ] && PATH="$PATH:$GOBIN"
export GOPATH=$HOME/p/go
PATH=$PATH:$GOPATH/bin
# for scala add /usr/local/scala/sbt/bin
# for sml add   /usr/local/smlnj/bin
# for racket add /usr/local/racket/bin
# for pkgsrc: /usr/pkg/bin:/usr/pkg/sbin:
export PATH
[ -r "$HOME/.shrc" ] && export ENV=$HOME/.shrc
umask 2

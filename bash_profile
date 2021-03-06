# .bash_profile -- typically run for login shells/once per login
# vim: set filetype=sh:
# CLAIM: Mac OS X Terminal runs a login shell by default for each new terminal window
# iterm2 probably does this as well
# CLAIM: Cygwin also gives a new login shell for each window
#
# this file should hold bash-isms that can be inherited.
#
#DS="$HOME/dbg_start" && [ -w "$DS" ] && echo bash_profile "$(date '+%T.%N')" >> "$DS" # TODO debug
PROFILE="$HOME/.profile"
BASHRC="$HOME/.bashrc"
[ -r "$PROFILE" ] && . "$PROFILE"
[ -r "$BASHRC"  ] && . "$BASHRC"
export BASH_ENV=$ENV
# this isn't working in gnome terminal on az for some reason so there is
# another hack in .bashrc to fix
#export SHLVL_BASE=$SHLVL

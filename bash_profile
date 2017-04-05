# .bash_profile -- typically run for login shells/once per login
# CLAIM: Mac OS X Terminal runs a login shell by default for each new terminal window
# iterm2 probably does this as well
# CLAIM: Cygwin also gives a new login shell for each window
#
# this file should hold bash-isms that can be inherited.
#
PROFILE="$HOME/.profile"
BASHRC="$HOME/.bashrc"
[ -r "$PROFILE" ] && . "$PROFILE"
[ -r "$BASHRC"  ] && . "$BASHRC"
export BASH_ENV=$ENV

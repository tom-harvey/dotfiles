# .bashrc  invoked for interactive non-login shells
#
# If not running interactively, don't do anything
#[[ "$-" != *i* ]] && return
#
case $HOSTNAME in 
    neptune.* ) TAHCLR="31" ;; # red
    antenna.* ) TAHCLR="32" ;; # green
    im.* )      TAHCLR="33" ;; # yellow
    burn.* )    TAHCLR="33" ;;
    dell4.* )   TAHCLR="34" ;; # blue
    sherri.*)   TAHCLR="35" ;; # magenta
    mini.*)     TAHCLR="36" ;; # cyan
    aspen.*)    TAHCLR="36" ;; # cyan
    *)          TAHCLR="37" ;; # grey
esac
if [ $SHLVL -ge 2 ] ; then # subshell prompt enhancement
  if [ -z "$TAHLVL" ] ; then
    export TAHLVL="\[\e[43m\]" # highlight '>' in yellow
  else
    export TAHLVL="$TAHLVL>"   # append another '>'
  fi
fi
PROMPT_COMMAND='if jobs %1 &>/dev/null ; then TAHPR=";4" ; else TAHPR= ; fi ; PS1="\[\e[$TAHCLR$TAHPR;1m\]\h:\w$TAHLVL>\[\e[0m\]"'
set -o vi
export EDITOR=vi
alias grep='grep --color'  # show differences in colour
alias lines='wc -l'
alias more=less
#
# Some shortcuts for different directory listings
[[ -f ~/simple-dircolors ]] && eval "$(dircolors ~/simple-dircolors)"
# 
if [[ "${OSTYPE}" = cygwin* ]] ; then
    SSHAGENT=/usr/bin/ssh-agent
    SSHAGENTARGS="-s"
    if [ -z "$SSH_AUTH_SOCK" ] && [ -x "$SSHAGENT" ]; then
        eval "$($SSHAGENT $SSHAGENTARGS)"
        trap 'kill $SSH_AGENT_PID' 0
    fi
    alias ls='ls --color=auto' # default color is atrocious
#elif [ $OSTYPE = darwin* ] ; then
#    echo tah darwin .bashrc runs
#else
#    echo tah $OSTYPE .bashrc runs
fi

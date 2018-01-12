# .bashrc  invoked by bash for interactive non-login shells
#          invoked by my .bash_profile in a login shell
# vim: set filetype=sh:
#
# this file should contain ONLY bash-isms. 
#
# commands for interactive POSIX shell-compatible commands should be 
# in $ENV (.shinit)
#
#DS="$HOME/dbg_start" && [ -w "$DS" ] && echo bashrc "$(date '+%T.%N')" >> "$DS" # TODO debug
# If not running interactively, don't do anything else
[[ "$-" != *i* ]] && return
#[ -w "$DS" ] && echo bashrc-interactive "$(date '+%T.%N')" >> "$DS" # TODO debug

# $ENV isn't reliably run on all systems for each interactive session
# so ensure that it gets run if it exists
[ -z "$SHINIT_interactive" ] && [ -r "$ENV" ] && source "$ENV"
#
# bold colors other than red & black don't really work with 'solarized' palette
# so use non-bold prompt
# TODO get fancy with truecolor terminals, etc
# TODO hash a color from the $HOSTNAME ?
# colors 30:Black 31:Red 32:Green 33:Yellow 34:Blue 35:Magenta 36:Cyan 37:White 
case $HOSTNAME in 
    az* )             TAHCLR="36" ;;
    im* | burn*  )    TAHCLR="33" ;;
    nb* | dell4* )    TAHCLR="34" ;;
    lh* | sherri*)    TAHCLR="35" ;;
    jh* | mini*  )    TAHCLR="32" ;; 
    *)                TAHCLR="35" ;; # visible on all reasonable backgrounds
esac
# ignore first subshell if $TMUX is set? ( -v test not available pre 4.2)
shlvl=2 ; [[ $TMUX ]] && ((shlvl++))
# TODO quick hack: linux laptop "az" that starts at SHLVL 2 after 17.04 upgrade
[[ $HOSTNAME == "az" ]] && ((shlvl++))
if [ $SHLVL -ge $shlvl ] ; then # subshell prompt enhancement
  if [ -z "$TAHLVL" ] ; then
    export TAHLVL="\e[7m"     # 7 : reverse video mode
  else
    export TAHLVL="$TAHLVL>"   # append another '>'
  fi
fi
unset shlvl
#TODO truncate LHS of working directory when it gets too big
# super-clever truncation but using \w for now
#    pwd=${PWD: -$((${#PWD} > 35 ? 35 : ${#PWD}))}
#
# Use \[...\] around the parts of PS1 that have length 0. 
# It helps bash to get the length of the prompt right
#
PROMPT_COMMAND='
    if jobs %1 &>/dev/null ; then 
        TAHPR=";4" ; 
    else 
        TAHPR= ; 
    fi ; PS1="\[\e[$TAHCLR${TAHPR}m\]\h:\w\[$TAHLVL\]>\[\e[0m\]"'
alias grep='grep --color'  # show differences in colour
alias lines='wc -l'
alias more=less
#
# Some shortcuts for different directory listings
[[ -r ~/simple-dircolors ]] && eval "$(dircolors ~/simple-dircolors)"
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

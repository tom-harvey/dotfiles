# .bashrc  invoked by bash for interactive non-login shells
#          invoked by my .bash_profile in a login shell
#
# this file should contain ONLY bash-isms. 
# commands for interactive POSIX shell-compatible commands should be 
# in $ENV (.shinit)
#
[ -z "$SH_INIT" ] || [ -r "$ENV" ] && . "$ENV"
# If not running interactively, don't do anything else
[[ "$-" != *i* ]] && return
#
# bold colors other than red & black don't really work with 'solarized' palette
# so use non-bold prompt
# TODO get fancy with truecolor terminals, etc
# TODO hash a color from the $HOSTNAME ?
# colors 30:Black 31:Red 32:Green 33:Yellow 34:Blue 35:Magenta 36:Cyan 37:White 
case $HOSTNAME in 
    az* )             TAHCLR="36" ;;
    im* | burn* )     TAHCLR="33" ;;
    dell4* )          TAHCLR="34" ;;
    sherri*)          TAHCLR="35" ;;
    mini* | bart*)    TAHCLR="32" ;; 
    *)                TAHCLR="30" ;; # black (grey-37 often invisible)
esac
# ignore first subshell if $TMUX is set?
shlvl=2 ; [ -v TMUX ] && ((shlvl++))
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
PROMPT_COMMAND='
    if jobs %1 &>/dev/null ; then 
        TAHPR=";4" ; 
    else 
        TAHPR= ; 
    fi ; PS1="\e[$TAHCLR${TAHPR}m\h:\w$TAHLVL>\e[0m"'
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

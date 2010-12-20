# ~/.bashrc: executed by bash(1) for non-login shells. see
# /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for
# examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Foreground colors
BLACK='\[\033[30m\]'
BLUE='\[\033[34m\]'
GREEN='\[\033[32m\]'
CYAN='\[\033[36m\]'
RED='\[\033[31m\]'
PURPLE='\[\033[35m\]'
BROWN='\[\033[33m\]'
LIGHTGRAY='\[\033[37m\]'
DARKGRAY='\[\033[1;30m\]'
LIGHTBLUE='\[\033[1;34m\]'
LIGHTGREEN='\[\033[1;32m\]'
LIGHTCYAN='\[\033[1;36m\]'
LIGHTRED='\[\033[1;31m\]'
LIGHTPURPLE='\[\033[1;35m\]'
YELLOW='\[\033[1;33m\]'
WHITE='\[\033[1;37m\]'


# Background colors
BG_BLACK='\[\033[40m\]'
BG_BLUE='\[\033[44m\]'
BG_GREEN='\[\033[42m\]'
BG_CYAN='\[\033[46m\]'
BG_RED='\[\033[41m\]'
BG_PURPLE='\[\033[45m\]'
BG_BROWN='\[\033[43m\]'
BG_WHITE='\[\033[47m\]'

# Meta-colors
BOLD='\[\033[1m\]'
BLINK='\[\033[5m\]'
REVERSE='\[\033[7m\]'
NC='\[\033[0m\]'      # No Color

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth # ... and ignore same sucessive entries.
export HISTSIZE=9000
export HISTFILESIZE=9000

shopt -s checkwinsize
shopt -s cmdhist        # save multi-line commands as one line
shopt -s dotglob        # allow tab-completion of '.' filenames
shopt -s extglob        # bonus regex globbing!
shopt -s hostcomplete   # tab-complete words containing @ as hostnames
shopt -s histappend     # append to history
shopt -s nocaseglob
stty -ixon # disable Ctrl-S and Ctrl-Q, which suck!


#export PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\$ '
export PS1="${LIGHTGRAY}\u@${RED}\h${NC}:${LIGHTGRAY}\w${NC}\$ "
export EDITOR=vim
export BROWSER="/usr/bin/opera"

case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='history -a;history -n;echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
screen*)
    export PS1="${LIGHTGRAY}\u@${RED}\h${NC}:${LIGHTGRAY}\w $WINDOW${NC}"'\[\033k\033\\\]> '
    #export PS1="\u@\h \w"'\[\033k\033\\\]\$ '
    #function rename_screen_tab () { echo -ne "\x1bk$@\x1b\\"; return 0; }
    #PROMPT_COMMAND='rename_screen_tab ${PWD/$HOME/~}'
    PROMPT_COMMAND='history -a;history -n'
    ;;
*)
    ;;
esac

bc="/etc/profile.d/bash_completion.sh"
test -f $bc && source $bc

set -o vi

# ALIASES

alias ls='ls --color=never -H -F'
alias ll='ls -lha'
alias l='ls -lh'

alias h='history|grep'
alias hh='history 15'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i --preserve-root'

alias ot='pushd .'
alias to='popd'

alias y='yaourt'
alias psss='ps -ef|grep'
alias svim='sudo vim'
alias xpropc='xprop|grep WM_CLASS'
alias xpropp='xprop|grep -i'

dum() {
  n=$1
  shift
  du -hc --max-depth=$n $@
}

dr() { 
  sudo /etc/rc.d/$1 restart
}
ds() {
  sudo /etc/rc.d/$1 start
}
dt() {
  sudo /etc/rc.d/$1 stop
}


pss() {
  ps aux | grep $@ | grep -v grep
}

test -f ~/.bashrc.local && source ~/.bashrc.local

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

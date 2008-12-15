BLACK="%{"$'\033[01;30m'"%}"
GREEN="%{"$'\033[01;32m'"%}"
RED="%{"$'\033[01;31m'"%}"
YELLOW="%{"$'\033[01;33m'"%}"
BLUE="%{"$'\033[01;34m'"%}"
BOLD="%{"$'\033[01;39m'"%}"
NC="%{"$'\033[00m'"%}"

HOSTNAME=`hostname`
USER=`id -un`

#autoload colors; colors

case $HOSTNAME in
  poobar)
    hostcolor="$YELLOW" ;;
  berserk)
    hostcolor="$BLUE" ;;
  woot|museek4musicbrainz)
    hostcolor="$GREEN" ;;
  *)
    hostcolor="$NC" ;;
esac

case "$TERM" in
  xterm*|?rxvt*)
    # display user@host and full dir in *term title
    precmd () { print -Pn  "\033]0;%n@%m %~\007" }
    # display user@host and name of current process in *term title
    preexec () { print -Pn "\033]0;%n@%m <$1> %~\007" }
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
  screen*)
    # Set screen's window title to the command the user typed.
    preexec() { print -n '\ek'$1'\e\\' }

    # Restore a generic title if no program is running.
    precmd() { 
      print -n '\ek'$HOST:$PWD'\e\\'
    }
    PROMPT_COMMAND='echo -ne "\033k$HOSTNAME\033\\"'
    ;;
  *)
    ;;
esac

case $USER in
  palbo|pflouret)
    usercolor="$NC" ;;
  root)
    usercolor="$RED" ;;
  *)
    usercolor="$GREEN" ;;
esac

common_ps="%D{%k%M} ${usercolor}%n${NC}@${hostcolor}%m${NC}:%~"
export PS1="$common_ps $ "
export RPROMPT="!%h"

case $TERM in
  screen*)
    export PS1="$common_ps $WINDOW${NC}> "
  ;;
esac

if [ -n $MC_SID ]; then
  export RPROMPT=''
fi

function chpwd() {
  [[ -t 1 ]] || return
  case $TERM in
    *xterm*|rxvt*)
      print -Pn "\e]2;@%m:%~\a"
      ;;
  esac
}


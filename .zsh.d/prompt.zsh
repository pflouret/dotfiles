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
  xterm*|rxvt*)
    precmd () {
      print -Pn  "\033]0;%~\007"
    }

    preexec () { 
      print -Pn "\033]0;<$1>\007" 
    }
    ;;
  screen*)
    precmd () {
      print -Pn '\ek%~\e\\'
      print -Pn  "\033]0;%~\007"
    }

    preexec () { 
      print -Pn '\ek'$1'\e\\'
      print -Pn "\033]0;<$1>\007" 
    }
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


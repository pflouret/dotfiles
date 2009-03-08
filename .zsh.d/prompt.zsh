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
    hostcolor="$NC" ;;
  berserk)
    hostcolor="$BLUE" ;;
  woot|museek4musicbrainz)
    hostcolor="$YELLOW" ;;
  quux)
    hostcolor="$RED" ;;
  *)
    hostcolor="$GREEN" ;;
esac

case $USER in
  palbo|pflouret)
    usercolor="$GREEN" ;;
  root)
    usercolor="$RED" ;;
  *)
    usercolor="$NC" ;;
esac

if [[ -n $SUDO_USER || -n $SSH_TTY ]]; then
  rprompt="${usercolor}${USER}${NC}@${hostcolor}%m${NC}"
fi

prompt="${hostcolor}[${NC}${usercolor}%~${NC}${hostcolor}]${NC}: "

export PS1=$prompt

[[ -z $MC_SID ]] && export RPROMPT=$rprompt

case "$TERM" in
  xterm*|rxvt*)
    precmd () { print -Pn  "\033]0;%12<...<%~\007" }
    preexec () { print -Pn "\033]0;$1\007" }
    ;;
  screen*)
    precmd () {
      print -Pn '\ek%12<...<%~\e\\'
      print -Pn  "\033]2;%~\007"
    }

    preexec () { 
      print -Pn '\ek'$1'\e\\'
      print -Pn "\033]0;$1\007"
    }
    ;;
  *)
    ;;
esac


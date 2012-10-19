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
  chateaufort|berserk*)
    hostcolor="$NC" ;;
  ca88*)
    hostcolor="$YELLOW" ;;
  pipe|quux|woot)
    hostcolor="$RED" ;;
  *)
    hostcolor="$GREEN" ;;
esac

case $USER in
  pf|palbo|pflouret|thd864)
    usercolor="$YELLOW" ;;
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


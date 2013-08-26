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
  chateaufort|berserk*|pflouret-m*)
    hostcolor="$NC" ;;
  ca88*)
    hostcolor="$YELLOW" ;;
  parb.es|pipe|quux|woot|app*)
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

rprompt_host=""
if [[ -n $SUDO_USER || -n $SSH_TTY ]]; then
  rprompt_host="${usercolor}${USER}${NC}@${hostcolor}%m${NC}"
fi

prompt="${hostcolor}[${NC}${usercolor}%~${NC}${hostcolor}]${NC}: "

export PS1="$prompt"
export RPROMPT="$rprompt_host"

case "$TERM" in
  xterm*|rxvt*|screen*)
    precmd () {
        print -Pn  "\033]0;%12<...<%~\007"
        print -Pn '\ek%12<...<%~\e\\'
        print -Pn  "\033]2;%~\007"
        extra=""
        if git rev-parse --git-dir &> /dev/null; then
            extra="${extra}[${RED}git${BLUE}:`git bb`]"
        fi
        if [[ -n $VM_HOSTNAME ]]; then
            extra="${extra}[${RED}vm${BLUE}:$VM_HOSTNAME]"
        fi
        export RPROMPT="$rprompt_host ${BLUE}$extra${NC}"
    }
    preexec () {
        print -Pn '\ek'$1'\e\\'
        print -Pn "\033]0;$1\007"
    }
    ;;
  *)
    ;;
esac


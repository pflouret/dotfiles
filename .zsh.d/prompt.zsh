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

case $USER in
  pf|palbo|pflouret|thd864|pablo_flouret)
    usercolor="$NC" ;;
  root)
    usercolor="$RED" ;;
  *)
    usercolor="$NC" ;;
esac

case $HOSTNAME in
  chateaufort|berserk*|*pflou*|loaners*|macpoo*|pfmb*)
    hostcolor="$BLUE" ;;
  i-*)
    hostcolor="$GREEN"
    usercolor="$YELLOW" ;;
  parb.es|app*|radio*)
    hostcolor="$RED" ;;
  *)
    hostcolor="$GREEN" ;;
esac

rprompt_host=""
if [[ -n $SUDO_USER || -n $SSH_TTY ]]; then
  rprompt_host="${usercolor}${USER}${NC}@${hostcolor}%m${NC}"
fi

prompt="${hostcolor}[${NC}${usercolor}%~${NC}${hostcolor}]${NC}: "

export PS1="$prompt"
rprompt_base="${YELLOW}%D{%T}${NC} $rprompt_host"
export RPROMPT="$rprompt_base"

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
        export RPROMPT="$rprompt_base ${BLUE}$extra${NC}"
    }
    preexec () {
        print -Pn '\ek'$1'\e\\'
        print -Pn "\033]0;$1\007"
    }
    ;;
  *)
    ;;
esac


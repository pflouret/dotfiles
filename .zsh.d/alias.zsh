
coreutils=`brew info coreutils|grep default-names`
if [[ `uname` == 'Darwin' ]] && [ ! $coreutils ]; then
    alias ls="ls -GHF"
else
    alias ls='ls --color=auto -HF'
fi
hash dircolors &> /dev/null && eval `dircolors -b`

alias cp='nocorrect cp'
alias mv='nocorrect mv'
alias rm='nocorrect rm --preserve-root'

alias ll='ls -lha'
alias l='ls -lh'
alias lsd='ls -ld *(/)'  # only show directories
alias lad='ls -ld .*(/)' # only show dot-directories
alias lsa='ls -a .*(.)'  # only show dot-files
alias lsbig='ls -lSrh'   # display the biggest files

alias h='history 0|grep'

alias ot='pushd .'
alias to='popd'

alias b='brew'
alias bi='brew install'
alias bs='brew search'
alias y='yaourt'
alias yi='yaourt -Qii'
alias yl='yaourt -Ql'
alias yo='yaourt -Qo'

alias dh='df -h'
alias psss='ps -ef|grep'
alias xpropc='xprop|grep WM_CLASS'
alias xpropp='xprop|grep -i'
alias weeknumber='echo WEEK `date +%V`'

alias -g LL='|less'

dum() {
  n=$1
  shift
  du -hc --max-depth=$n $@
}

pss() {
  ps aux | grep $@ | grep -v grep
}

findd() {
  find . $@ -type d
}

findf() {
  find . $@ -type f
}

findn() {
  name=$1
  shift
  find . $@ -name $name
}

function mkcd() {
  [ -n "$1" ] && mkdir -p "$@" && cd "$1";
}

function growl() {
    echo '\e]9;\007'
}

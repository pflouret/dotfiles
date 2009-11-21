alias ls='ls --color=auto -H -F'
alias ll='ls -lha'
alias l='ls -lh'
alias lsd='ls -ld *(/)'  # only show directories
alias lad='ls -ld .*(/)' # only show dot-directories
alias lsa='ls -a .*(.)'  # only show dot-files
alias lsbig='ls -lSrh'   # display the biggest files

alias h='history 0|grep'

alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i --preserve-root'
#alias find='noglob find'

alias grepc='grep -C 2'
alias grepcc='grep -C'
alias grepo='grep -o'

alias ot='pushd .'
alias to='popd'

alias y='yaourt'
alias yi='yaourt -Qii'
alias yl='yaourt -Ql'
alias t='tupac'
alias ti='tupac -Qii'
alias tl='tupac -Ql'

alias dh='df -h'
alias psss='ps -ef|grep'
alias svim='sudo vim'
alias xpropc='xprop|grep WM_CLASS'
alias xpropp='xprop|grep -i'


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
  find $@ -type d
}

findf() {
  find $@ -type f
}

findn() {
  name=$1
  shift
  find $@ -name $1
}

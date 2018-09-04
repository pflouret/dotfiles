
if ls --color &> /dev/null; then
    alias ls='ls --color=auto -HF'
else
    # Darwin
    alias ls="ls -GHF"
fi

alias cp='nocorrect cp'
alias mv='nocorrect mv'
alias rm='nocorrect rm --preserve-root'

alias ll='ls -lha'
alias l='ls -lh'
alias lsd='ls -ld *(/)'  # only show directories
alias lad='ls -ld .*(/)' # only show dot-directories
alias lsa='ls -a .*(.)'  # only show dot-files
alias lsbig='ls -lSrh'   # display the biggest files
alias macls="/bin/ls -laO@"

alias h='history 0|grep -i'
hh() {
    grep -ie $1 ~/.zhistory|sed 's/^: [0-9]*:[0-9];//'
}

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
alias fs="stat -f \"%z bytes\""

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip='ipconfig getifaddr en1|perl -pe "s/\r|\n//m"'
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias omg="say -r 350 -v trinoids omg omg omg; terminal-notifier -message 'omg omg omg'"

alias g="gradle"
alias gd="gradle --no-daemon"
alias grepl='$GRADLEW javarepl --no-daemon --console plain'

dum() {
  n=$1
  shift
  du -hc --max-depth=$n $@
}

pss() {
  ps aux | grep -i $@ | grep -v grep
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

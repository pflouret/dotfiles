
_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1  # Because we didn't really complete anything
}

zstyle ':completion:*' completer _force_rehash _complete _prefix _expand _ignored
zstyle ':completion:*:^(vim):*' completer _gnu_generic
zstyle ':completion:*' ignore-parents pwd directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zshcache
zstyle ':completion:*' menu select=5
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

autoload -U zargs

#compdef pkill=killall

zstyle ':completion:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,args --sort cmd,args'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 

zstyle ':completion:*:xmms2:*' menu yes select
zstyle ':completion:*:git:*' menu yes select
zstyle ':completion:*:brew:*' menu yes select
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select=3

zstyle ':completion:*:(vim|cp):*' ignored-patterns '*.(pyc|o)'

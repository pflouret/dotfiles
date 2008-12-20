#zstyle ':completion:*' completer _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' completer _expand _complete _prefix
zstyle ':completion:*' ignore-parents pwd directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' menu yes select
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

autoload -U zargs

compdef pkill=killall
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,args --sort cmd,args'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 

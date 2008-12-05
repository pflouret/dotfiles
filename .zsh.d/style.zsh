#zstyle ':completion:*' completer _expand _complete _ignored _match _approximate _prefix
zstyle ':completion:*' completer _expand _complete _prefix
zstyle ':completion:*' ignore-parents pwd directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U zargs

compdef pkill=killall

#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:kill:*' force-list always
#zstyle ':completion:*:kill:*:processes' command 'ps x'
#zstyle ":completion:*:processes" command ps --forest -A -o pid,cmd
#zstyle ":completion:*:processes" list-colors '=(#b)( #[0-9]#)[&[/0-9a-zA-Z]#(*)=34=37;1=30;1'
#zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
#zstyle ':completion:*:kill:*' insert-ids single
#zstyle ':completion:*:kill:*' force-list always


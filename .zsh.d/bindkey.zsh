hostname=`hostname`

zkbddir=~/.zsh.d/zkbd
if [ -f $zkbddir/$TERM-$hostname ]; then
  source $zkbddir/$TERM-$hostname
elif [ -f $zkbddir/$TERM ]; then
  source $zkbddir/$TERM
else
  nozkbd=1
fi

WORDCHARS=${WORDCHARS//[&=\/;!#%\{]}

bindkey -v

if [ -n $nozkbd ]; then
  bindkey -v "^H" backward-delete-char
  bindkey -v "^?" backward-delete-char
  bindkey "^[[3~" delete-char
else
  [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
  [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
  [[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-history
  [[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-history
  [[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
  [[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
  [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
  [[ -n ${key[Backspace]} ]] && bindkey -v "${key[Backspace]}" backward-delete-char
fi

bindkey -v "^W" backward-delete-word
bindkey "^P" up-history
bindkey "^N" down-history
bindkey "^R" history-incremental-search-backward
bindkey "\e[Z" undo  # shift-tab
bindkey "^Z" undo
bindkey '^i' expand-or-complete-prefix

zmodload zsh/complist
bindkey -M menuselect "/"  accept-and-infer-next-history
bindkey -M menuselect "\e[Z"  reverse-menu-complete

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
      LBUFFER+=/..
  else
      LBUFFER+=.
  fi
}

zle -N rationalise-dot
bindkey . rationalise-dot


export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zhistory

export EDITOR=vim
export BROWSER="/usr/bin/opera"

eval `dircolors -b`

for f in ~/.zsh.d/*.zsh; do
  source $f
done

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi


export HISTSIZE=20000
export SAVEHIST=20000
export HISTFILE=~/.zhistory

export EDITOR=vim
export BROWSER="/usr/bin/opera"

export PAGER="less"
export LESS="FRX"
export GREP_OPTIONS="--color=auto"

eval `dircolors -b`

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

for f in ~/.zsh.d/*.zsh; do
  source $f
done


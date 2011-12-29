export HISTSIZE=20000
export SAVEHIST=20000
export HISTFILE=~/.zhistory
export CLICOLOR=1

export EDITOR=vim
export BROWSER="opera"

export PAGER="less"
export LESS="FRX"
export GREP_OPTIONS="--color=auto"

fpath=($fpath ~/.zsh.d/completion)

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

for f in ~/.zsh.d/*.zsh; do
  source $f
done

eval `dircolors -b`

test -f "$HOME/.rvm/scripts/rvm" && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

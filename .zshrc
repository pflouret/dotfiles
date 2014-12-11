export HISTSIZE=99999
export SAVEHIST=$HISTSIZE
export HISTFILE=~/.zhistory
export CLICOLOR=1

export EDITOR=vim
export BROWSER="open -a Firefox"

export PAGER="less"
export LESS="FRX"
export GREP_OPTIONS="--color=auto"

fpath=($fpath /usr/local/share/zsh-completions ~/.zsh.d/completion)

for f in ~/.zsh.d/*.zsh; do
  source $f
done

test -f "$HOME/.rvm/scripts/rvm" && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

test -f ~/.zshrc.local && source ~/.zshrc.local


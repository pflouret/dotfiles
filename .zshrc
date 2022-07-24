export HISTSIZE=9999999
export SAVEHIST=$HISTSIZE
export HISTFILE=~/.zhistory
export CLICOLOR=1

export EDITOR=vim
export BROWSER="open -a Vivaldi"
export GOPATH=/usr/local/go

export PAGER="less"
export LESS="FRX"
export GREP_OPTIONS="--color=auto"
export JQ_COLORS="1;31:0;39:0;39:0;39:0;32:1;39:1;39"

fpath=($fpath /usr/local/share/zsh-completions ~/.zsh.d/completion)

for f in ~/.zsh.d/*.zsh; do
  source $f
done

# test -f "$HOME/.rvm/scripts/rvm" && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

test -f ~/.zshrc.local && source ~/.zshrc.local
type rbenv &> /dev/null && eval "$(rbenv init -)"
type direnv &> /dev/null && eval "$(direnv hook zsh)"

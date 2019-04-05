export NVM_DIR="$HOME/.nvm"
export ONETOUCHGEN_ACCEPT_EULA=yep
export SATURN5_HOST=i-0f5e54297cab38400.inst.aws.airbnb.com
export ENV=development

test -f /usr/local/opt/nvm/nvm.sh && source /usr/local/opt/nvm/nvm.sh
test -f ~/.airlab/shellhelper.sh && source ~/.airlab/shellhelper.sh
type kubectl &> /dev/null && source <(kubectl completion zsh)
type rbenv &> /dev/null && eval "$(rbenv init -)"
#alias assh="ssh airlab -L 3897:localhost:3897 -t 'screen -RD'"
alias assh="ssh airlab -t 'screen -RD'"
alias rc1="ssh rc1.musta.ch -t 'screen -RD'"
alias rc-next="ssh rc-next.musta.ch -t 'screen -RD'"
alias rc="rc-next"

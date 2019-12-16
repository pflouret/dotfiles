export NVM_DIR="$HOME/.nvm"
export ONETOUCHGEN_ACCEPT_EULA=yep
export ENV=development
export K2=y
export RC_HOST=i-060f1afb2acdc05c3.inst.aws.airbnb.com
export RCNEXT_HOST=i-0cd25cb48ccfdb331.inst.aws.airbnb.com
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export GITHUB_URL=https://git.musta.ch

test -f /usr/local/opt/nvm/nvm.sh && source /usr/local/opt/nvm/nvm.sh
test -f ~/.airlab/shellhelper.sh && source ~/.airlab/shellhelper.sh
type kubectl &> /dev/null && source <(kubectl completion zsh)
alias assh="ssh airlab -t 'screen -RD'"
alias rc1="ssh $RC_HOST -t 'screen -RD'"
alias rc-next="ssh $RCNEXT_HOST -t 'screen -RD'"
alias rc="rc-next"
alias dyno='eval `dyno_cookie`'

export DATA_DIR=$HOME/airlab/repos/data
export AFDEV_HOST="i-0fe8c7016ebd6679a.inst.aws.airbnb.com"
export AFDEV_PORT=62883
export AFDEV_USER="$USER"

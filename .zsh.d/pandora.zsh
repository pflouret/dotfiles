export ANT_HOME=$HOME/local/ant
export MACOSX_DEPLOYMENT_TARGET=10.7
export P4CLIENT=pflouret-m01
export PGDATA=$HOME/local/postgres/data
export VM_HOSTNAME=localhost
export VM_ROOT=$HOME/vm_localhost

alias startpg='pg_ctl -D $HOME/local/postgres/data -l $HOME/local/postgres/logfile start'
alias stoppg='pg_ctl -D $HOME/local/postgres/data -l $HOME/local/postgres/logfile stop'
alias statuspg='pg_ctl status'
alias pgstart=startpg
alias pgstop=stoppg
alias pgstatus=statuspg

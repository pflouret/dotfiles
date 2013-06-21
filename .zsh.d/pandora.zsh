export ANT_HOME=$HOME/local/ant
export MACOSX_DEPLOYMENT_TARGET=10.7
export P4CLIENT=pflouret-m01
export PGDATA=$HOME/local/postgres/data
export VM_HOSTNAME=localhost
export VM_ROOT=$HOME/vm_localhost
export PYTHON_HOME=$HOME/local/python-2.7.3
export JYTHON_HOME=$HOME/local/jython2.2.1

alias startpg='pg_ctl -D $HOME/local/postgres/data -l $HOME/local/postgres/logfile start'
alias stoppg='pg_ctl -D $HOME/local/postgres/data -l $HOME/local/postgres/logfile stop'
alias statuspg='pg_ctl status'
alias pgstart=startpg
alias pgstop=stoppg
alias pgstatus=statuspg

SRC=~/dev/main
PROJECTS=~/dev/main/SavageBeast/Engineering/projects

alias p="cd $PROJECTS"
alias m="cd $SRC"
alias vmconfig='vim ~/vm_localhost/.vm_config'
alias buildjs="pushd $PROJECTS/radio/src/js > /dev/null ; ant ; cp -f -u $SRC/stage/radio/www/*.js $VM_ROOT/documentRoot/www ; cp -f -u -r $SRC/stage/radio/www/src $VM_ROOT/documentRoot/www 2> /dev/null ; cw ; css ; popd > /dev/null"
alias cw="cp -f -u -R $PROJECTS/radio/www/* $VM_ROOT/documentRoot/www ; TIMESTAMP=`date +%N%s` ; sed "s/\@CACHE_BUSTER@/$TIMESTAMP/g" $PROJECTS/radio/web/index.jsp > $VM_ROOT/documentRoot/radio/index.jsp"
alias css='pushd $PROJECTS/radio > /dev/null ; ant compile.css ; cp -f -u $SRC/stage/radio/www/css/compiled.css $VM_ROOT/documentRoot/www/css ; popd > /dev/null'

function jsdebug {
    case $1 in
        "on")
            export JS_DEBUG=true
            export JS_LOGGING=true
            export JS_PRETTY_PRINT=true
            ;;
        "off")
            unset JS_DEBUG
            unset JS_LOGGING
            unset JS_PRETTY_PRINT
            ;;
    esac
}

jsdebug on


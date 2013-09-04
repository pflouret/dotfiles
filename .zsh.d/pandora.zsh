export ANT_HOME=$HOME/local/ant
export MACOSX_DEPLOYMENT_TARGET=10.7
export P4CLIENT=pflouret-m01
export PGDATA=$HOME/local/postgres/data
export PYTHON_HOME=$HOME/local/python-2.7.3
export JYTHON_HOME=$HOME/local/jython2.2.1

alias startpg='pg_ctl -D $HOME/local/postgres/data -l $HOME/local/postgres/logfile start'
alias stoppg='pg_ctl -D $HOME/local/postgres/data -l $HOME/local/postgres/logfile stop'
alias statuspg='pg_ctl status'
alias pgstart=startpg
alias pgstop=stoppg
alias pgstatus=statuspg

alias vmconfig="vim \$VM_ROOT/.vm_config"
alias cdvm="cd \$VM_ROOT"

setvm() {
    if [ ! -z $1 ]; then
        if [ ! -d ~/vm/$1 ]; then
            echo "$0: error: Bad vm: '$1'"
            return 1;
        fi
        export VM_HOSTNAME=$1
        export VM_ROOT=~/vm/$1
    fi
    echo "VM_HOSTNAME=$VM_HOSTNAME"
    echo "VM_ROOT=$VM_ROOT"
}

test -e ~/bin/allutils && relsb_path=~/bin sysdb_path=$relsb_path source ~/bin/allutils

jsdebug() {
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
        *)
            echo "JS_DEBUG=$JS_DEBUG"
            echo "JS_LOGGING=$JS_LOGGING"
            echo "JS_PRETTY_PRINT=$JS_PRETTY_PRINT"
            ;;
    esac
}

jsdebug on

# Reverse integrate all new changes from main into the current (custom) branch
alias integmain='p4 integ -r -d -b $CODELINE //depot/main/... //depot/$CODELINE/...'

PROJECTS_REL_DIR=SavageBeast/Engineering/projects

src_dir() {
    src=~/dev/main
    d=`pwd`
    while [ $d != / ]; do
        if [ -d "$d/$PROJECTS_REL_DIR" ]; then
            echo "$d"
            return
        fi
        d=`dirname $d`
    done
    echo "$src"
}

projects_dir() {
    echo "$(src_dir)/$PROJECTS_REL_DIR"
}

# Show last perforce checkin by current user
pp() {
    p4 describe -s `p4 changes -u $USER -m 1 | awk '{print $2}'`
}

# Integrate a changelist from release codeline back to main
# $1 -> codeline $2 -> changelist
i() {
    p4 integ -b $1 @$2,@$2
    p4 resolve -am
}

# Reverse integrate a changelist from main to release codeline
# $1 -> codeline $2 -> changelist
ri() {
    p4 integ -r -b $1 @$2,@$2
    p4 resolve -am
}

alias p="cd \$(projects_dir)"
alias m="cd \$(src_dir)"
alias buildjs="pushd \$(projects_dir)/radio/src/js > /dev/null ; ant ; cp -f -u \$(src_dir)/stage/radio/www/*.js $VM_ROOT/documentRoot/www ; cp -f -u -r \$(src_dir)/stage/radio/www/src $VM_ROOT/documentRoot/www 2> /dev/null ; cw ; css ; popd > /dev/null"
alias cw="cp -f -u -R \$(projects_dir)/radio/www/* $VM_ROOT/documentRoot/www ; TIMESTAMP=`date +%N%s` ; sed "s/\@CACHE_BUSTER@/$TIMESTAMP/g" \$(projects_dir)/radio/web/index.jsp > $VM_ROOT/documentRoot/radio/index.jsp"
alias css="pushd \$(projects_dir)/radio > /dev/null ; ant compile.css ; cp -f -u \$(src_dir)/stage/radio/www/css/compiled.css $VM_ROOT/documentRoot/www/css ; popd > /dev/null"

if [[ ! -n $SSH_TTY ]]; then
    setvm main &> /dev/null
fi

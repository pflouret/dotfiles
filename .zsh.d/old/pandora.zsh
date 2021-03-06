export ANT_HOME=$HOME/local/ant
export ANT_OPTS="-Xms256m -Xmx1024m"
#export MACOSX_DEPLOYMENT_TARGET=10.7
export P4CLIENT=pflouret-m01
export PGDATA=$HOME/local/postgres/data
export PYTHON_HOME=$HOME/local/python-2.7.3
export JYTHON_HOME=$HOME/local/jython2.2.1
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8.0_66)
export JAVA_HOME=$JAVA_8_HOME
export EXCLUDE_HTML5_VERSIONS=true

alias startpg='pg_ctl -D $HOME/local/postgres/data -l $HOME/local/postgres/logfile start'
alias stoppg='pg_ctl -D $HOME/local/postgres/data -l $HOME/local/postgres/logfile stop'
alias statuspg='pg_ctl status'
alias pgstart=startpg
alias pgstop=stoppg
alias pgstatus=statuspg

alias vmconfig="vim \$VM_ROOT/.vm_config"
alias cdvm="cd \$VM_ROOT"
alias cdlog="cd \$VM_ROOT/var/log/radio"

setvm() {
    if [ ! -z $1 ]; then
        if [ $1 != "." ] && [ $1 != ".." ] && [ -d ~/vm/$1 ]; then
            export VM_HOSTNAME=$1
            export VM_ROOT=~/vm/$1
        else
            p=`readlink -f "$1"`
            export VM_HOSTNAME=`basename $p`
            export VM_ROOT=$p
        fi
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
# $1 -> changelist
i() {
    p4 integ -b $CODELINE @$1,@$1
    p4 resolve -am
}

# Reverse integrate a changelist from main to release codeline
# $1 -> changelist
ri() {
    p4 integ -r -b $CODELINE @$1,@$1
    p4 resolve -am
}

jenkins_build() {
    branch=`git bb 2> /dev/null`
    if [ ! -z $1 ]; then
        branch=$1
    fi
    url="http://psy:8080/view/pandoraone-minaj/job/p1-pflouret-git-build/buildWithParameters?token=conga&GIT_BRANCH=$branch"
    curl "$url"
    open "http://psy:8080/view/pandoraone-minaj/job/p1-pflouret-git-build/"
}

alias nag="p4 integ -n -b \$CODELINE"
alias p="cd \$(projects_dir)"
alias m="cd \$(src_dir)"
alias buildjs="pushd \$(projects_dir)/radio/src/js > /dev/null ; ant ; cp -f -u \$(src_dir)/stage/radio/www/*.js \$VM_ROOT/documentRoot/www ; cp -f -u -r \$(src_dir)/stage/radio/www/src \$VM_ROOT/documentRoot/www 2> /dev/null ; cw ; css ; popd > /dev/null"
alias cw="cp -v -f -u -R \$(projects_dir)/radio/www/* \$VM_ROOT/documentRoot/www ; TIMESTAMP=`date +%N%s` ; sed "s/\@CACHE_BUSTER@/$TIMESTAMP/g" \$(projects_dir)/radio/web/index.jsp > \$VM_ROOT/documentRoot/radio/index.jsp"
alias css="pushd \$(projects_dir)/radio > /dev/null ; ant compile.css sass ; cp -f -u -R \$(src_dir)/stage/radio/www/css/* \$VM_ROOT/documentRoot/www/css ; popd > /dev/null"
alias cptest="(cd \$(projects_dir)/radio/test && find ./ -name '*.py' -exec cp -f -u --parents -v {} \$VM_ROOT/radio/test \; && chmod 755 \$VM_ROOT/radio/test/*/*.py)" ;
alias cpadops="cp -v -f -u -R \$(projects_dir)/adops/web/* \$VM_ROOT/adops/web/adops"
alias cpcust="cp -v -f -u -R \$(projects_dir)/customerservice/web/* \$VM_ROOT/customerservice/web/customerservice"

if [[ ! -n $SSH_TTY ]]; then
    setvm main &> /dev/null
fi

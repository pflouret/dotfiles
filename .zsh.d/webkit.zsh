function set-webkit-path() {
    S="Tools/Scripts";
    d=`pwd`;
    while [ $d != ~ ]; do
        if [ -d "$d/$S" ]; then
            echo "$0: using $d/$S";
            export PATH="$d/$S":$PATH;
            alias drt="$d/Source/WebKit/chromium/xcodebuild/Debug/DumpRenderTree.app/Contents/MacOS/DumpRenderTree"
            return 0;
        else
            d=`dirname $d`;
        fi
    done
    echo "$0: error: No Tools/Scripts folder found." >&2;
    return 1;
}

function bwf() {
    if ! hash build-webkit &> /dev/null && ! set-webkit-path &> /dev/null; then
        echo "$0: error: no build-webkit on PATH" >&2;
        return 1;
    fi

    p=`which build-webkit`
    base=${p%%/Tools/Scripts/build-webkit}
    mv -f $base/build.log{,.bak} &> /dev/null
    time build-webkit --makeargs='-j5' --debug $@ 2>&1 | tee $base/build.log
    growlnotify -m "Finished compiling" -a Safari
}

function bwm() {
    features=(
    --javascript-debugger
    --web-audio
    --geolocation
    --fullscreen-api
    --css-filters
    --filters
    --workers
    --shared-workers
    --netscape-plugin-api
    )

    bwf --minimal $features $@;
}

function bw() {
    features=(
    --no-css-exclusions
    --no-css-regions
    --no-icon-database
    --no-mathml
    --no-mutation-observers
    --no-sql-database
    --no-svg
    --no-svg-dom-objc-bindings
    --no-svg-fonts
    --no-webgl
    --no-web-sockets
    --no-xslt
    )

    bwf $features $@;
}

function bwc {
    bwf --chromium --v8
}

function wt() {
    if ! hash new-run-webkit-tests &> /dev/null && ! set-webkit-path &> /dev/null; then
        echo "$0: error: no build-webkit on PATH" >&2;
        return 1;
    fi

    new-run-webkit-tests --debug -f --child-processes=7 --no-retry $@
}

function wtq() {
    wt --no-show-results --no-record-results $@
}

alias wp="webkit-patch"
export CHANGE_LOG_EDITOR=vim


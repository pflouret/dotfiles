#if hash /opt/homebrew/bin/brew &> /dev/null; then
#    coreutils=$(brew --prefix coreutils)/libexec/gnubin;
#fi
coreutils=$(/opt/homebrew/bin/brew --prefix coreutils)/libexec/gnubin;

if hash launchctl &> /dev/null; then
    launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist &> /dev/null
    launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.plist &> /dev/null
fi

export PATH=.:~/bin:$coreutils:/opt/homebrew/bin:/usr/local/sbin:/usr/local/bin:/usr/local/go/bin:$PATH

if [[ `uname` == "Linux" ]]; then
    SSH_ENV="$HOME/.ssh/environment"
    function start_agent {
        /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
        chmod 600 "${SSH_ENV}"
        . "${SSH_ENV}" > /dev/null
    }

    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            start_agent;
        }
    else
        start_agent;
    fi
fi

test -f ~/.zprofile.local && source ~/.zprofile.local

# Setting PATH for Python 2.7
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

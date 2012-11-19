coreutils=""
if hash brew &> /dev/null; then
    coreutils=$(brew --prefix coreutils)/libexec/gnubin;
fi

export PATH=.:~/bin:$coreutils:/usr/local/sbin:/usr/local/bin:$PATH

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

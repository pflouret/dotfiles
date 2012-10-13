coreutils=""
if hash brew &> /dev/null; then
    coreutils=$(brew --prefix coreutils)/libexec/gnubin;
fi

export PATH=.:~/bin:$coreutils:/usr/local/sbin:/usr/local/bin:$PATH

if [ -x /usr/bin/keychain ]; then
  keychain --clear -q --timeout 2880
  source ~/.keychain/`hostname`-sh > /dev/null
fi

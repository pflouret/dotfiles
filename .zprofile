export PATH=.:~/bin:$PATH:~/opt/eclipse

if [ -x /usr/bin/keychain ]; then
  keychain --clear -q
  source ~/.keychain/`hostname`-sh > /dev/null
fi

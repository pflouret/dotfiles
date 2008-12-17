export PATH=.:~/bin:$PATH:~/opt/eclipse

if [ -x /usr/bin/keychain ]; then
  keychain --clear -q --timeout 2880
  source ~/.keychain/`hostname`-sh > /dev/null
fi

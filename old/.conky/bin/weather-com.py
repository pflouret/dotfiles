#!/usr/bin/env python

import dns.resolver
import httplib
import signal
import sys

from xml.dom import minidom

PATH = '/weather/local/NOXX0029?prod=xoap&link=xoap&cc=*&dayf=0&unit=m&par=1084340912&key=6eda6b79a8b3abd2'
USER_AGENT = 'Opera/9.60 (X11; Linux i686; U; en) Presto/2.1.1'

def main():
  signal.signal(signal.SIGALRM, lambda *a: 0)
  try:
    signal.alarm(2)
    dns.resolver.query('xoap.weather.com')
  except:
    print 'ERR'
    sys.exit(1)

  h = httplib.HTTPConnection('xoap.weather.com', timeout=1)

  h.request('GET', PATH, headers={'User-Agent': USER_AGENT})
  r = h.getresponse()

  if r.status != 200:
    print 'ERR %d' % r.status
    sys.exit(1)

  dom = minidom.parse(r)

  h.close()

  ut = dom.getElementsByTagName('ut')[0].firstChild.data

  cc = dom.getElementsByTagName('cc')[0]
  temp = cc.getElementsByTagName('tmp')[0].firstChild.data
  desc = cc.getElementsByTagName('t')[0].firstChild.data
  humidity = cc.getElementsByTagName('hmid')[0].firstChild.data

  print '%s %s%s %s%%' % (desc.lower(), temp, ut, humidity)


if __name__ == '__main__':
  main()


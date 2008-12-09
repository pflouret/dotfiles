#!/usr/bin/env python

import httplib
import sys

from xml.dom import minidom

PATH = '/weather/local/NOXX0029?cc=*&dayf=0&unit=m'#&par=1084340912key=6eda6b79a8b3abd2'
USER_AGENT = 'Opera/9.60 (X11; Linux i686; U; en) Presto/2.1.1'

def main():
  h = httplib.HTTPConnection('xoap.weather.com')

  h.request('GET', PATH, headers={'User-Agent': USER_AGENT})
  r = h.getresponse()

  if r.status != 200:
    print 'ERR %d' % r.status
    sys.exit(1)

  dom = minidom.parse(r)

  h.close()

  temp = dom.getElementsByTagName('tmp')[0].firstChild.data
  ut = dom.getElementsByTagName('ut')[0].firstChild.data
  desc = dom.getElementsByTagName('t')[0].firstChild.data
  humidity = dom.getElementsByTagName('hmid')[0].firstChild.data

  print '%s %s%s %s%%' % (desc.lower(), temp, ut, humidity)


if __name__ == '__main__':
  main()


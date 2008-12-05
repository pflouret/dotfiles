#!/usr/bin/env python

import httplib
import optparse
import sys

from xml.dom import minidom

__version__ = '0.1'

PATH = '/ig/api?weather=%s'
USER_AGENT = 'Opera/9.60 (X11; Linux i686; U; en) Presto/2.1.1'

def main(opts):
  h = httplib.HTTPConnection('www.google.com')

  h.request('GET', PATH % opts.location, headers={'User-Agent': USER_AGENT})
  r = h.getresponse()

  if r.status != 200:
    print 'ERR %d' % r.status
    sys.exit(1)

  dom = minidom.parse(r)

  h.close()

  temp = dom.getElementsByTagName('temp_c')[0].getAttribute('data')
  humidity = dom.getElementsByTagName('humidity')[0].getAttribute('data')[-4:]

  if humidity[0] == ' ':
    humidity = humidity[1:]

  print '%sC %s' % (temp, humidity)


if __name__ == '__main__':
  parser = optparse.OptionParser(version='%%prog v%s' % __version__)
  parser.add_option('-l', '--location', dest='location', metavar='LOCATION',
                    default='oslo', help='city or location')

  opts, args = parser.parse_args()
  main(opts)


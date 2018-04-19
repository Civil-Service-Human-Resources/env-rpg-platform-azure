#!/usr/bin/env python

import ipaddress, sys

ips_file = open(sys.argv[1], "r")

print ('[')

for line in ips_file.readlines():
    iprange = ipaddress.ip_network(unicode(line, 'utf-8').decode('utf-8','ignore').strip('\n'))
    print ('\t\t\t"' + str(iprange[0]) + ',' +str(iprange[-1]) + '",')

print (']')


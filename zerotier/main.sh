#!/bin/bash

/usr/local/bin/zerotier-one -d
bash /usr/local/bin/connect2anycast.sh -u "$RAGE4_USERNAME" -p "$RAGE4_API" -a "$RAGE4_ASN" -r par

ip link add dummy0 type dummy
ip link set dummy0 up
ip -4 addr add dev dummy0 $ANYCAST_IPv4/32
ip -6 addr add dev dummy0 $ANYCAST_IPv6/128

ip link add dummy1 type dummy
ip link set dummy1 up
ip -4 addr add dev dummy1 $ANYCAST2_IPv4/32
ip -6 addr add dev dummy1 $ANYCAST2_IPv6/128

echo '666       anycast' >> /etc/iproute2/rt_tables
ip -4 rule add from $ANYCAST_IPv4/32 table anycast
ip -4 rule add from $ANYCAST2_IPv4/32 table anycast
ip -6 rule add from $ANYCAST_IPv6/128 table anycast
ip -6 rule add from $ANYCAST2_IPv6/128 table anycast
ip -4 route add default via 172.31.255.125 table anycast
ip -6 route add default via fd00:dead:c0de:cafe:172:31:255:125 table anycast
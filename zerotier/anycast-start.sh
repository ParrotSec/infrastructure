#!/bin/bash

ip4=("185.187.152.2/32" "185.187.153.2/32")
ip6=("2a05:b0c4:1::c/128" "2a05:b0c4:1::d/128")
gw4="172.31.255.109" #nyc gateway
gw6="fd00:dead:c0de:cafe:172:31:255:109" #nyc gateway6

dn="dummy0"

sleep .5

modprobe dummy

ip link set $dn down &> /dev/null
ip link del dev $dn type dummy &> /dev/null

ip link add $dn type dummy
ip link set $dn up

if [ "" == "`cat /etc/iproute2/rt_tables | grep anycast`" ]; then
 echo '666       anycast' >> /etc/iproute2/rt_tables
fi

for ip in ${ip4[@]}; do
 ip -4 addr add dev $dn $ip
 ip -4 rule add from $ip table anycast
done

ip -4 route add default via $gw4 table anycast

for ip in ${ip6[@]}; do
 ip -6 addr add dev $dn $ip
 ip -6 rule add from $ip table anycast
done

ip -6 route add default via $gw6 table anycast
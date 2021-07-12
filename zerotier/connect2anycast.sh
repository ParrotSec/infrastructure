#!/bin/bash

anycast_url='https://rage4.com'
anycast_username=''
anycast_password=''
anycast_region=''
anycast_zerotier=''
anycast_asnum=''
anycast_network='6ab565387a056897'

#################################################

while getopts u:p:r:z:a: option; do
case "${option}"
in
u) anycast_username=${OPTARG};;
p) anycast_password=${OPTARG};;
r) anycast_region=${OPTARG};;
z) anycast_zerotier=${OPTARG};;
a) anycast_asnum=${OPTARG};;
esac
done

if [[ "$anycast_username" == "" || "$anycast_password" == "" || "$anycast_region" == "" || "$anycast_asnum" == "" ]]; then
 echo "usage connect2anycast -u <Rage4 username> -p <Rage4 API key> -r <AnycastIP region code> -a <AnycastIP ASNum>"
 exit 1
fi

zerotier_path=`which zerotier-cli`

if [[ "$zerotier_path" == "" ]]; then
 echo "ERROR: please install ZeroTier first, see https://www.zerotier.com/download/ for details"
 exit 1
fi

if [[ "$anycast_zerotier" == "" ]]; then
 anycast_zerotier=`zerotier-cli info | awk '{ print $3 }'`
fi

if [[ "$anycast_zerotier" == "" ]]; then
 echo "ERROR: unable to detect ZeroTier address"
 exit 1
fi

status=`zerotier-cli join $anycast_network | grep "200" | awk '{ print $(NF)}'`

if [[ "$status" != "OK" ]]; then
 echo "ERROR: unable to join $anycast_network"
 exit 1
fi

address="$anycast_url/anycastapi/createnodeforasn/?zerotier=$anycast_zerotier&code=$anycast_region&asnum=$anycast_asnum"
status=`wget --user=$anycast_username --password=$anycast_password --auth-no-challenge -qO- $address`

if [[ "$status" == "ok" ]]; then
 echo "OK: node has been added successfully"
else
 echo "ERROR: unable to add node $anycast_zerotier to $anycast_network ($anycast_region)"
 exit 1
fi


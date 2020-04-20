#!/bin/bash

while true; do
	geoipupdate --config-file /etc/GeoIP.conf  --database-directory /var/lib/GeoIP/
	wget -qO - https://dl.miyuru.lk/geoip/dbip/city/dbip4.dat.gz | gzip -d > /var/lib/GeoIP/dbipcity4.dat.temp
	wget -qO - https://dl.miyuru.lk/geoip/dbip/city/dbip6.dat.gz | gzip -d > /var/lib/GeoIP/dbipcity6.dat.temp

	v4cursize=$(wc -c < dbipcity4.dat)
	v6cursize=$(wc -c < dbipcity6.dat)
	v4newsize=$(wc -c < dbipcity4.dat)
	v6newsize=$(wc -c < dbipcity6.dat)
	if [ $v4newsize -ge 1567236 ]; then
		mv /var/lib/GeoIP/dbipcity4.dat.temp /var/lib/GeoIP/dbipcity4.dat
	fi
	if [ $v6newsize -ge 1567236 ]; then
		mv /var/lib/GeoIP/dbipcity6.dat.temp /var/lib/GeoIP/dbipcity6.dat
	fi
	sleep 86400
done

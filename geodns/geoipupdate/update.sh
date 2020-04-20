#!/bin/bash

while true; do
        geoipupdate --config-file /etc/GeoIP.conf  --database-directory /var/lib/GeoIP/
        wget -qO - https://dl.miyuru.lk/geoip/dbip/city/dbip4.dat.gz | gzip -d > /var/lib/GeoIP/dbipcity4.dat.temp || true 
        wget -qO - https://dl.miyuru.lk/geoip/dbip/city/dbip6.dat.gz | gzip -d > /var/lib/GeoIP/dbipcity6.dat.temp || true

        v4cursize=$(wc -c < /var/lib/GeoIP/dbipcity4.dat)
        v6cursize=$(wc -c < /var/lib/GeoIP/dbipcity6.dat)
        v4newsize=$(wc -c < /var/lib/GeoIP/dbipcity4.dat.temp)
        v6newsize=$(wc -c < /var/lib/GeoIP/dbipcity6.dat.temp)
        if [ $v4newsize -ge 1567236 ]; then
                mv /var/lib/GeoIP/dbipcity4.dat.temp /var/lib/GeoIP/dbipcity4.dat || true
        fi
        if [ $v6newsize -ge 1567236 ]; then
                mv /var/lib/GeoIP/dbipcity6.dat.temp /var/lib/GeoIP/dbipcity6.dat || true
        fi
        rm /var/lib/GeoIP/*.temp || true
        sleep 86400
done
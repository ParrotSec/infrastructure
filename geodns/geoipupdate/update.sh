#!/bin/bash

while true; do
	geoipupdate --config-file /etc/GeoIP.conf  --database-directory /var/lib/GeoIP/
	sleep 86400
done

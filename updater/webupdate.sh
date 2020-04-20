#!/bin/bash

SITE_SOURCE="/ipns/www.parrotsec.org"
SITE_TARGET="/var/www/html"
DOCS_SOURCE="/ipns/docs.parrotsec.org"
DOCS_TARGET="/var/www/docs"
STATIC_SOURCE="/ipns/static.parrotsec.org"
STATIC_TARGET="/var/www/static"


while true; do
	ipfs --api=/ip4/172.18.44.2/tcp/5001 get $SITE_SOURCE -o $SITE_TARGET
    ipfs --api=/ip4/172.18.44.2/tcp/5001 get $DOCS_SOURCE -o $DOCS_TARGET
    ipfs --api=/ip4/172.18.44.2/tcp/5001 get $STATIC_SOURCE -o $STATIC_TARGET
	sleep 300
done
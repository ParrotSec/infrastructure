#!/bin/bash

export SITE_SOURCE="/ipns/www.parrotsec.org"
export SITE_TARGET="/var/www/html"
export DOCS_SOURCE="/ipns/docs.parrotsec.org"
export DOCS_TARGET="/var/www/docs"
export STATIC_SOURCE="/ipns/static.parrotsec.org"
export STATIC_TARGET="/var/www/static"


while true; do
    ipfs --api="/ip4/172.18.44.2/tcp/5001" get $(SITE_SOURCE) -o $(SITE_TARGET)
    ipfs --api="/ip4/172.18.44.2/tcp/5001" get $(DOCS_SOURCE) -o $(DOCS_TARGET)
    ipfs --api="/ip4/172.18.44.2/tcp/5001" get $(STATIC_SOURCE) -o $(STATIC_TARGET)
    sleep 300
done
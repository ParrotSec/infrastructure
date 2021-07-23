#!/bin/bash

/usr/local/bin/zerotier-one -d
bash /usr/local/bin/connect2anycast.sh -u "$RAGE4_USERNAME" -p "$RAGE4_API" -a "$RAGE4_ASN" -r "$RAGE4_REGION"
#!/bin/bash


if [ -f /mirrors.sh ]; then
	bash /mirrors.sh
fi

/usr/bin/mirrorbits daemon -config /etc/mirrorbits.conf

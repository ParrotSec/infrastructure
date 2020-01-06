FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.2

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install fail2ban;rm -rf /var/lib/apt/lists/*

STOPSIGNAL SIGTERM
CMD mkdir -p /var/run/fail2ban;/usr/bin/fail2ban-server -xf start

FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.2

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install pdns-server pdns-backend-geoip; \
	echo > /etc/powerdns/pdns.d/bind.conf; \
	rm -rf /var/lib/apt/lists/*

STOPSIGNAL SIGTERM
CMD /usr/sbin/pdns_server --guardian=no --daemon=no --disable-syslog --log-timestamp=no --write-pid=no

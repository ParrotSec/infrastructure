FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.2

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install pdns-recursor; \
	rm -rf /var/lib/apt/lists/*

STOPSIGNAL SIGTERM
CMD /usr/sbin/pdns_recursor --daemon=no --write-pid=no --disable-syslog --log-timestamp=no

FROM debian:bullseye
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.6

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install pdns-recursor; \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/pdns-recursor

STOPSIGNAL SIGTERM
CMD /usr/sbin/pdns_recursor --daemon=no --write-pid=no --disable-syslog --log-timestamp=no

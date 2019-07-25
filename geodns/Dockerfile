FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install pdns-server pdns-backend-geoip pdns-recursor dnsdist geoip-database-extra golang-go; \
	echo > /etc/powerdns/pdns.d/bind.conf; \
	rm -rf /var/lib/apt/lists/*

COPY start.go /start.go

RUN go build /start.go


EXPOSE 80 443
STOPSIGNAL SIGTERM
CMD /start

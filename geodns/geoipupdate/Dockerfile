FROM debian:bullseye
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.3

# Update system
RUN sed -i "s/main/main contrib/g" /etc/apt/sources.list && apt-get update && apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install geoipupdate ssl-cert ca-certificates wget curl; \
	rm -rf /var/lib/apt/lists/*

COPY update.sh /update.sh

RUN chmod +x /update.sh

CMD /update.sh
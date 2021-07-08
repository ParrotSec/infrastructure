FROM debian:bullseye
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.2

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install rsync;rm -rf /var/lib/apt/lists/*
RUN touch /cache.db


EXPOSE 873
STOPSIGNAL SIGTERM
CMD /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf "$@"

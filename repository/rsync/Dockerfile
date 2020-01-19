FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install rsync;rm -rf /var/lib/apt/lists/*

# Add unprivileged user
RUN useradd -ms /usr/sbin/nologin -d /var/www/ www-data


EXPOSE 873
STOPSIGNAL SIGTERM
CMD /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf "$@"

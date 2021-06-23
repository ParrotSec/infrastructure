FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.4

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install fail2ban;rm -rf /var/lib/apt/lists/*

# Customize configs
RUN sed -i "s/loglevel = INFO/loglevel = WARNING/g" /etc/fail2ban/fail2ban.conf; \
    sed -i "s/logtarget = \/var\/log\/fail2ban.log/logtarget = STDOUT/g" /etc/fail2ban/fail2ban.conf

STOPSIGNAL SIGTERM
CMD mkdir -p /var/run/fail2ban;/usr/bin/fail2ban-server -xf start

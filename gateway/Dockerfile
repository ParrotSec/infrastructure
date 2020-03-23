FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.2

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install nginx ssl-cert libnginx-mod-http-fancyindex nginx-extras;rm -rf /var/lib/apt/lists/*

COPY default /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/nginx.conf


EXPOSE 80 443
STOPSIGNAL SIGTERM
CMD /usr/sbin/nginx -g "daemon off;"
FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.2

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/* #;echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

# Install dependencies
RUN apt-get update;apt-get -y install nginx ssl-cert;rm -rf /var/lib/apt/lists/*


EXPOSE 80 443
STOPSIGNAL SIGTERM
CMD nginx -g "daemon off;"

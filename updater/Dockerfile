FROM debian:bullseye
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.3

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install rsync wget curl git;rm -rf /var/lib/apt/lists/*

COPY ./update.sh /update.sh
COPY ./webupdate.sh /webupdate.sh
RUN chmod +x /update.sh /webupdate.sh

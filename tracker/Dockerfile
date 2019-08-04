FROM debian:buster AS tracker-build
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/* #;echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

# Install dependencies
RUN apt-get update;apt-get -y install golang-go curl git;rm -rf /var/lib/apt/lists/*

# Install software
RUN git clone https://github.com/chihaya/chihaya.git; \
	cd chihaya; \
	CGO_ENABLED=0 GO111MODULE=on go build ./cmd/chihaya; \
	mv chihaya /tracker; \
	chmod +x /tracker

STOPSIGNAL SIGTERM

ENTRYPOINT ["/tracker", "--config", "/config.conf"]

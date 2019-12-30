FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1


RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

RUN apt-get update;apt-get -y install golang-go; \
	apt -y install	golang \
					curl \
					git \
					rsync \
					ssl-cert \
					hugo \
					jekyll \
					ruby-jekyll \
					mkdocs \
					mkdocs-bootstrap \
					mkdocs-bootswatch \
					mkdocs-nature; \
	go build /manager.go -o /usr/local/bin/manager; \
	rm -rf /var/lib/apt/lists/*

COPY manager.go /manager.go

RUN go build -o /usr/local/bin/manager manager.go

CMD /usr/local/bin/manager

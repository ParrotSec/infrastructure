FROM parrotsec/core:latest
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Update system
RUN apt update;apt -y full-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt update;apt -y install rsync rclone golang-go;rm -rf /var/lib/apt/lists/*

# Install software
RUN go get github.com/parrotsec/mirrordirector
RUN touch /cache.db


EXPOSE 8080
STOPSIGNAL SIGTERM
CMD /root/go/bin/mirrordirector

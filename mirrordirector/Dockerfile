FROM parrotsec/core:latest
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.7

# Update system
RUN echo "deb https://mirror.parrot.sh/direct/parrot/ lts main" > /etc/apt/sources.list.d/parrot.list \
    echo "deb https://mirror.parrot.sh/direct/parrot/ lts-updates main" >> /etc/apt/sources.list.d/parrot.list \
    echo "deb https://mirror.parrot.sh/direct/parrot/ lts-backports main" >> /etc/apt/sources.list.d/parrot.list \
    echo "deb https://mirror.parrot.sh/direct/parrot/ lts-security main" >> /etc/apt/sources.list.d/parrot.list
RUN apt update;apt -y --allow-downgrades full-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt update;apt -y install rsync rclone golang-go;rm -rf /var/lib/apt/lists/*

# Install software
ENV REBUILD 1
RUN go get github.com/parrotsec/mirrordirector
RUN touch /cache.db


EXPOSE 8080
STOPSIGNAL SIGTERM
CMD /root/go/bin/mirrordirector

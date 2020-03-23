FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install rsync geoip-database geoip-database-extra wget;rm -rf /var/lib/apt/lists/*

# Install mirrorbits
RUN wget https://github.com/etix/mirrorbits/releases/download/v0.5.1/mirrorbits-v0.5.1.tar.gz -O mirrorbits.tar.gz;\
    tar xvf mirrorbits.tar.gz;\
    mv mirrorbits/mirrorbits /usr/local/bin/mirrorbits;\
    ln -s /usr/local/bin/mirrorbits /usr/local/bin/mb;\
    mkdir -p /usr/local/share/mirrorbits/;\
    mv mirrorbits/templates/ /usr/local/share/mirrorbits/

COPY mirrorbits.conf /etc/mirrorbits.conf
COPY init.sh /init.sh

CMD bash /init.sh
ENTRYPOINT /usr/local/bin/mirrorbits daemon && while [[ $(ps -e | grep mirrorbits) ]]; do sleep 5; done

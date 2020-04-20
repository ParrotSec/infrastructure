FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update;apt-get -y install rsync wget curl;rm -rf /var/lib/apt/lists/*

# Install ipfs
RUN wget https://dist.ipfs.io/go-ipfs/v0.4.23/go-ipfs_v0.4.23_linux-amd64.tar.gz; \
    tar xf go-ipfs_v0.4.23_linux-amd64.tar.gz;\
    cd go-ipfs;\
    ./install.sh;\
    cd ..; rm -rf go-ipfs

COPY ./update.sh /update.sh
COPY ./webupdate.sh /webupdate.sh
RUN chmod +x /update.sh /webupdate.sh

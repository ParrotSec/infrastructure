FROM debian:buster
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Update system
RUN apt-get update;apt-get -y dist-upgrade; rm -rf /var/lib/apt/lists/*

# Configure services
RUN apt-get update;apt-get -y install golang-go git make pkg-config zlib1g-dev protobuf-compiler libprotoc-dev rsync; rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/etix/mirrorbits.git && \
    cd mirrorbits && \
    make install && \
    go get -u github.com/maxmind/geoipupdate2/cmd/geoipupdate && \
    go install -ldflags "-X main.defaultConfigFile=/etc/GeoIP.conf -X main.defaultDatabaseDirectory=/usr/share/GeoIP" github.com/maxmind/geoipupdate2/cmd/geoipupdate && \
    echo "AccountID 0\nLicenseKey 000000000000\nEditionIDs GeoLite2-City GeoLite2-Country GeoLite2-ASN" > /etc/GeoIP.conf && \
    mkdir /usr/share/GeoIP && \
    /go/bin/geoipupdate



EXPOSE 8080
STOPSIGNAL SIGTERM
ENTRYPOINT /usr/local/bin/mirrorbits daemon -config /etc/mirrorbits.conf

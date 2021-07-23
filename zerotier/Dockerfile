FROM debian:bullseye as builder
MAINTAINER Lorenzo "Palinuro" Faletra (palinuro@linux.it)
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.1

# Install dependencies
RUN apt update;apt -y full-upgrade;apt -y install clang git make;rm -rf /var/lib/apt/lists/*

# Install software
RUN git clone https://github.com/zerotier/ZeroTierOne zerotier
WORKDIR /zerotier
RUN make


FROM parrotsec/core:latest

RUN apt update;apt -y full-upgrade;apt -y install bird iproute2 net-tools wget;rm -rf /var/lib/apt/lists/*

COPY --from=builder /zerotier/zerotier-one /usr/local/bin/zerotier-one
COPY --from=builder /zerotier/zerotier-cli /usr/local/bin/zerotier-cli
COPY connect2anycast.sh /usr/local/bin/connect2anycast.sh
COPY main.sh /usr/local/bin/main.sh

CMD /usr/local/bin/main.sh
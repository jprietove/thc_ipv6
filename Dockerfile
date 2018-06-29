# thc-ipv6 container
# vanhauser-thc
FROM jprietove/nuc
MAINTAINER Javier Prieto <javier.prieto.edu@juntadeandalucia.es>

LABEL Title="THC-IPv6 Container based on Ubuntu"

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get install -y git libpcap-dev libssl-dev libnetfilter-queue-dev
RUN git clone https://github.com/vanhauser-thc/thc-ipv6.git 
WORKDIR /thc-ipv6
RUN make all && make install

RUN apt-get install -y iptables
RUN echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.conf
RUN ip6tables -I OUTPUT -p icmpv6 --icmpv6-type redirect -j DROP

ENTRYPOINT bash


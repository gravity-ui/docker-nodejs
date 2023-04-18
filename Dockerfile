FROM ubuntu:20.04

ARG CERT

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata && \
    apt-get -y install nano vim nginx curl git telnet bzip2 iproute2 wget supervisor && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# unlink default nginx config to prevent default server duplication error
RUN unlink /etc/nginx/sites-enabled/default

# adding certificate
RUN mkdir /etc/crt
RUN echo $CERT > /etc/crt/cert.pem
RUN echo $CERT > /usr/local/share/ca-certificates/cert.pem
ENV NODE_EXTRA_CA_CERTS=/etc/crt/cert.pem

RUN useradd -r app

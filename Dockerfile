FROM ubuntu:20.04

# arg declartions
ARG CERT

# timezone setting
ENV TZ="Etc/UTC"
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

# deps installation
COPY ./scripts/ /tmp/scripts/
RUN chmod +x /tmp/scripts/setup_18.x
RUN /tmp/scripts/setup_18.x
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install tzdata && \
    apt-get -y install nano vim nginx curl git telnet bzip2 iproute2 wget supervisor nodejs

# cleanup tmp and defaults
RUN rm -rf /etc/nginx/sites-enabled/default /var/lib/apt/lists/* /tmp/scripts

# adding certificate
RUN echo $CERT > /usr/local/share/ca-certificates/cert.pem
ENV NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/cert.pem
RUN update-ca-certificates

# users setting
RUN useradd -r app

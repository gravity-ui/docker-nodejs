ARG UBUNTU_VERSION=22.04

FROM ubuntu:${UBUNTU_VERSION}

# arg declarations
ARG NODE_MAJOR=20
ARG ADDITIONAL_PACKAGES=""

ENV DEBIAN_FRONTEND=noninteractive

# timezone setting
ENV TZ="Etc/UTC"
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# deps and nodejs installation
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl gnupg ${ADDITIONAL_PACKAGES} && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get -y install nodejs

# remove unnecessary packages and defaults config
RUN apt-get -y purge curl gnupg gnupg2 && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /etc/nginx/sites-enabled/default 

# users setting
RUN useradd -r app && mkdir /opt/app && chown app:app /opt/app

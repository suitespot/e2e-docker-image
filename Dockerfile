FROM ubuntu:jammy-20231211.1

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Base tools & JRE
RUN apt-get update && \
  apt-get install -y curl wget default-jre gnupg lsb-release jq ripgrep moreutils

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN node --version && npm --version

# Install mongosh
ENV MONGOSH_DL_URL="https://downloads.mongodb.com/compass/mongodb-mongosh_2.1.1_amd64.deb"
RUN curl -o ./mongosh.deb -L ${MONGOSH_DL_URL} && \
  dpkg -i ./mongosh.deb && \
  rm ./mongosh.deb

# Remove apt cache
RUN rm -rf /var/lib/apt/lists/*

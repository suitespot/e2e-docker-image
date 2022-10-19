FROM ubuntu:bionic-20181112

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Base tools & JRE
RUN apt-get update && \
  apt-get install -y curl wget default-jre

# Install NVM and Node
RUN curl https://get.volta.sh | bash
ENV PATH="${PATH}:/root/.volta/bin"
RUN volta install node@^16 && npm version

# Remove apt cache
RUN rm -rf /var/lib/apt/lists/*

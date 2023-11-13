FROM ubuntu:bionic-20221215

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Base tools & JRE
RUN apt-get update && \
  apt-get install -y curl wget default-jre gnupg lsb-release

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN node --version && npm --version

# Install MongoDB
RUN apt-get install libcurl4 openssl liblzma5
ENV MONGO_VERSION="6.0.11" 
ENV PLATFORM="ubuntu1804"
ENV MONGO_DIR="mongodb-linux-x86_64-${PLATFORM}-${MONGO_VERSION}"
ENV MONGO_TGZ="${MONGO_DIR}.tgz"
RUN wget https://fastdl.mongodb.org/linux/${MONGO_TGZ} && \
  tar -zxvf ${MONGO_TGZ} && \
  rm ${MONGO_TGZ} && \
  cp ${MONGO_DIR}/bin/* /usr/bin

# Remove apt cache
RUN rm -rf /var/lib/apt/lists/*

FROM ubuntu:jammy-20231211.1

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Base tools & JRE
RUN apt-get update && \
  apt-get install -y curl wget default-jre gnupg lsb-release jq ripgrep moreutils

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs
RUN node --version && npm --version

# Install MongoDB
RUN apt-get install -y libcurl4 libgssapi-krb5-2 libldap-2.5-0 libwrap0 libsasl2-2 libsasl2-modules libsasl2-modules-gssapi-mit snmp openssl liblzma5
ENV MONGO_VERSION="6.0.12" 
ENV PLATFORM="ubuntu2204"
ENV MONGO_DIR="mongodb-linux-x86_64-${PLATFORM}-${MONGO_VERSION}"
ENV MONGO_TGZ="${MONGO_DIR}.tgz"
RUN wget https://fastdl.mongodb.org/linux/${MONGO_TGZ} && \
  tar -zxvf ${MONGO_TGZ} && \
  rm ${MONGO_TGZ} && \
  cp ${MONGO_DIR}/bin/* /usr/bin

# Remove apt cache
RUN rm -rf /var/lib/apt/lists/*

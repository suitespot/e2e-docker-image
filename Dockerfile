FROM ubuntu:bionic-20181112

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Base tools & JRE
RUN apt-get update && \
  apt-get install -y curl wget default-jre

# Install NVM and Node
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
ENV NVM_DIR="/root/.nvm" \
  NODE_VERSION="10.16.3" \
  NPM_VERSION="6.11.3"
ENV PATH="${NVM_DIR}/versions/node/v${NODE_VERSION}/bin:$PATH"
RUN source ${NVM_DIR}/nvm.sh && \
  nvm install ${NODE_VERSION} && \ 
  npm install -g npm@${NPM_VERSION} && \
  node -v && \
  npm -version

# Install Mongo - see https://gist.github.com/masatomo/983a84bad9671dc29213
# also https://superuser.com/questions/1215294/mongo-cannot-see-libssl-and-libcrypto-files
# Download Center: https://www.mongodb.com/download-center/community?jmp=docs
RUN apt-get install --reinstall libssl1.0.0
ENV MONGO_VERSION="4.2.1" 
ENV MONGO_DIR="mongodb-linux-x86_64-ubuntu1804-${MONGO_VERSION}"
ENV MONGO_TGZ="${MONGO_DIR}.tgz"
RUN wget https://fastdl.mongodb.org/linux/${MONGO_TGZ} && \
  tar xvzf ${MONGO_TGZ} && \
  rm ${MONGO_TGZ} && \
  cp ${MONGO_DIR}/bin/* /usr/bin && \
  rm -rf ${MONGO_DIR} && \
  mongo -version

# Remove apt cache
RUN rm -rf /var/lib/apt/lists/*

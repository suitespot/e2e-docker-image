FROM ubuntu:bionic

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Base tools
RUN apt-get update && \
  apt-get install -y curl wget

# Install NVM and Node
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 8.9.4
ENV NPM_VERSION 6.4.0
RUN source ${NVM_DIR}/nvm.sh && \
  nvm install ${NODE_VERSION} && \ 
  npm install -g npm@${NPM_VERSION}

ENV PATH ${NVM_DIR}/versions/node/v${NODE_VERSION}/bin:$PATH

RUN node -v
RUN npm -version

# Install Mongo - see https://gist.github.com/masatomo/983a84bad9671dc29213
# also https://superuser.com/questions/1215294/mongo-cannot-see-libssl-and-libcrypto-files
RUN apt-get install --reinstall libssl1.0.0
ENV MONGO_VERSION "4.0.1"
ENV MONGO_DIR "mongodb-linux-x86_64-ubuntu1404-${MONGO_VERSION}"
ENV MONGO_TGZ "${MONGO_DIR}.tgz"
RUN wget https://fastdl.mongodb.org/linux/${MONGO_TGZ} && \
  tar xvzf ${MONGO_TGZ} && \
  rm ${MONGO_TGZ} && \
  cp ${MONGO_DIR}/bin/* /usr/bin && \
  mongo -version

# Install JRE
RUN apt-get update && apt-get install -y default-jre

# Install Chrome
RUN apt-get install -y chromium-browser

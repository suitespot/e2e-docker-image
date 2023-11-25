FROM --platform=linux/amd64 cimg/node:16.20.2-browsers

# Base tools & JRE
RUN sudo apt-get update && \
  sudo apt-get install -y curl wget default-jre gnupg lsb-release gnupg2 ca-certificates jq ripgrep
# Dependencies for Chrome 
RUN sudo apt-get install -y libgtk2.0-0 libgtk-3-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb

# Install MongoDB
RUN sudo apt-get install -y libcurl4 openssl liblzma5 libssl-dev
ENV MONGO_VERSION="6.0.11" 
ENV PLATFORM="ubuntu1804"
ENV MONGO_DIR="mongodb-linux-x86_64-${PLATFORM}-${MONGO_VERSION}"
ENV MONGO_TGZ="${MONGO_DIR}.tgz"
RUN wget https://fastdl.mongodb.org/linux/${MONGO_TGZ} && \
  tar -zxvf ${MONGO_TGZ} && \
  rm ${MONGO_TGZ} && \
  sudo cp ${MONGO_DIR}/bin/* /usr/bin
ENV MONGOSH_DL_URL="https://downloads.mongodb.com/compass/mongodb-mongosh_2.1.0_arm64.deb"
RUN curl -o ./mongosh.deb -L ${MONGOSH_DL_URL} && \
  sudo dpkg -i ./mongosh.deb && \
  rm ./mongosh.deb

# Remove apt cache
RUN rm -rf /var/lib/apt/lists/*

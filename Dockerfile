FROM ubuntu:16.04

ENV INSTALL_PATH=/adbase \
    BUILD_PACKAGES="curl wget apt-transport-https python-software-properties"

RUN mkdir $INSTALL_PATH

WORKDIR $INSTALL_PATH

RUN apt-get update \
    && apt-get install -y $BUILD_PACKAGES \
     python3 python3-pip libpq-dev python3-dev \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && apt-get install -y yarn \
    && apt-get remove --purge -y $BUILD_PACKAGES \
    && rm -rf /var/lib/apt/lists/*

COPY . $INSTALL_PATH

RUN pip3 install -r $INSTALL_PATH/requirements.txt -r ./deps/dev.txt \
    && yarn
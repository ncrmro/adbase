FROM ubuntu:16.04

ENV INSTALL_PATH=/src/ \
    BUILD_PACKAGES="curl wget apt-transport-https python-software-properties"


RUN mkdir $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY ./deps/ $INSTALL_PATH/deps/

COPY ./deps/package.json $INSTALL_PATH/package.json

RUN apt-get update \
    && apt-get install -y $BUILD_PACKAGES \
     python3 python3-pip libpq-dev python3-dev \
     && pip3 install virtualenv \
     && virtualenv .venv \
     && exec /bin/bash \
     && source .venv/bin/activate \
     && pip3 install -r $INSTALL_PATH/deps/requirements.txt

RUN  curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update


RUN wget -qO- https://github.com/mozilla/geckodriver/releases/download/v0.13.0/geckodriver-v0.13.0-linux64.tar.gz  | tar -xvz -C /usr/local/bin \
    && chmod +x /usr/local/bin/geckodriver


RUN apt-get install -y nodejs \
    && apt-get install -y yarn

RUN apt-get remove --purge -y $BUILD_PACKAGES \
    && rm -rf /var/lib/apt/lists/*

RUN yarn
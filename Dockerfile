FROM ubuntu:16.04

ENV INSTALL_PATH=/ango \
    BUILD_PACKAGES="apt-transport-https python-software-properties"

WORKDIR $INSTALL_PATH

# Get ubuntu, python, nodejs and yarn set up
RUN apt-get update \
    && apt-get install -y $BUILD_PACKAGES curl python3 python3-pip libpq-dev python3-dev git \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y nodejs \
    && apt-get install -y yarn \
    && apt-get remove --purge -y $BUILD_PACKAGES

COPY . $INSTALL_PATH/

RUN pip3 install --upgrade pip && pip3 install -r $INSTALL_PATH/requirements.txt && yarn


FROM node:6.9.5-alpine

ENV INSTALL_PATH=/reango \
    BUILD_PACKAGES="apt-transport-https python-software-properties"

WORKDIR $INSTALL_PATH

COPY . $INSTALL_PATH/

RUN apk add -U --no-cache python3 ca-certificates postgresql-dev gcc python3-dev musl-dev git && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    pip3 install -r requirements.txt && \
    npm install --global yarn && \
    yarn


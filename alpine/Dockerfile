FROM node:6.9.5-alpine

ENV INSTALL_PATH=/reango
#    BUILD_PACKAGES="apt-transport-https python-software-properties"

WORKDIR $INSTALL_PATH

COPY . $INSTALL_PATH/

RUN apk add -U --no-cache python3 ca-certificates postgresql-dev gcc python3-dev musl-dev git libffi && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache-dir --upgrade pip setuptools && \
    rm -r /root/.cache && \
    pip3 install --no-cache-dir -r requirements.txt && \
    npm install --global yarn && \
    npm cache clean && \
    yarn && yarn cache clean && \
    apk del musl-dev zlib-dev openssl-dev
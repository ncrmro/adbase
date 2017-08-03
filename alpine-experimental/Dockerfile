FROM node:8.1.2-alpine

ENV INSTALL_PATH=/reango
#    BUILD_PACKAGES="apt-transport-https python-software-properties"
#    POST_BUILD="python3"

WORKDIR $INSTALL_PATH

COPY . $INSTALL_PATH/

# Notes on making image smaller
# ca-certificates used for anything ssl https related
# Celery beat or Scrappy libxml2 libxml2-dev
# Psycopg2 python3 python3-dev postgresql-dev
# Gitlab checkout Git
RUN apk add -U --no-cache python3 ca-certificates postgresql-dev gcc python3-dev musl-dev git libffi libffi-dev linux-headers libxml2 libxml2-dev libxslt-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache-dir --upgrade pip setuptools && \
    rm -r /root/.cache && \
    pip3 install --no-cache-dir -r requirements.txt && \
    npm install --global yarn && \
    npm cache clean --force && \
    yarn && yarn cache clean && \
    apk del musl-dev zlib-dev openssl-dev postgresql-dev gcc python3-dev musl-dev git libffi libffi-dev linux-headers libxml2 libxml2-dev libxslt-dev


# docker build -t ncrmro/adbase:alpine-experimental . && docker push ncrmro/adbase:alpine-experimental
# Original is 365MB at time of creation
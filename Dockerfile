FROM python:3.6-alpine

ENV INSTALL_PATH=/src \
    BUILD_PACKAGES="curl bash wget binutils tar"

RUN mkdir $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY ./deps/ $INSTALL_PATH/deps/

COPY ./package.json $INSTALL_PATH/package.json
COPY ./yarn.lock $INSTALL_PATH/yarn.lock

RUN apk add --no-cache --virtual .build-deps \
  build-base postgresql-dev libffi-dev $BUILD_PACKAGES \
  && pip3 install -r $INSTALL_PATH/deps/requirements.txt \
  && wget -qO- https://github.com/mozilla/geckodriver/releases/download/v0.13.0/geckodriver-v0.13.0-linux64.tar.gz  | tar -xvz -C /usr/local/bin \
  && chmod +x /usr/local/bin/geckodriver \
  && apk add --update nodejs=6.7.0-r0 \
  && npm install --global yarn \
  && yarn \
  && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
    )" \
    && apk add --virtual .rundeps $runDeps \
    && apk del .build-deps $BUILD_PACAKGES

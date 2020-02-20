FROM jamiehewland/alpine-pypy:3-alpine3.11
LABEL maintainer "Jacob <sirrkitt@gmail.com>"

RUN mkdir /config /data

RUN pypy3 -m pip install --upgrade radicale radicale-imap

VOLUME /config
VOLUME /data

ENTRYPOINT [ "/usr/local/bin/radicale", "--config", "/config/radicale.conf" ]

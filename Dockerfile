FROM pypy:3-slim
LABEL maintainer "Jacob <sirrkitt@gmail.com>"

RUN mkdir /config /data

RUN pypy3 -m pip install --upgrade radicale https://github.com/Unrud/RadicaleIMAP/archive/master.zip

VOLUME /config
VOLUME /data

ENTRYPOINT [ "/usr/local/bin/radicale", "--config", "/config/radicale.conf" ]

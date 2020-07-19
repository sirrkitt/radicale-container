FROM pypy:3-slim

LABEL maintainer "Jacob <sirrkitt@gmail.com>"

ENV UIDS="5232"
ENV GIDS="5232"

COPY entrypoint.sh /entrypoint.sh

RUN mkdir /config /data
RUN set -eux; \
	apt update; \
	apt install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
	gosu nobody true

RUN pypy3 -m pip install --upgrade radicale https://github.com/Unrud/RadicaleIMAP/archive/master.zip &&\
	useradd --system --home-dir /data --shell /sbin/nologin radicale &&\
	chown -R radicale:radicale /config /data &&\
	chmod +x /entrypoint.sh


VOLUME /config
VOLUME /data


EXPOSE 5232

ENTRYPOINT [ "/entrypoint.sh" ]

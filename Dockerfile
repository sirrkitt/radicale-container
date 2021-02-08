FROM pypy:3.7-slim

LABEL maintainer "Jacob <sirrkitt@gmail.com>"

ENV	RELEASE="3.0.6"

ENV	PUID="5232"
ENV	PGID="5232"

COPY	entrypoint.sh /entrypoint.sh
COPY	radicale.conf /radicale.conf
COPY	gunicorn.py /gunicorn.py

RUN	pypy3 -m pip install --upgrade --no-cache-dir pip

RUN	pypy3 -m pip install --upgrade --no-cache-dir https://github.com/Kozea/Radicale/archive/3.0.6.zip https://github.com/Unrud/RadicaleIMAP/archive/master.zip gunicorn &&\
	chmod +x /entrypoint.sh

VOLUME	/config
VOLUME	/data
VOLUME	/socket

EXPOSE	5232

ENTRYPOINT [ "/entrypoint.sh" ]

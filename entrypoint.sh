#!/bin/sh
# make sure we can write to config
if [ ! -w "/config/" ]
then
	echo "Unable to read or write config directory!"
	exit 1
fi
if [ ! -r "/config/radicale.conf" ]
then
	echo "No config detected. Adding generic config"
	cp /radicale.conf /config/radicale.conf
fi
if [ ! -r "/config/gunicorn.py" ]
then
	echo "Gunicorn config not detected. Adding generic config"
	cp /gunicorn.py /config/gunicorn.py
fi

groupadd --system --gid $GIDS radicale
useradd --system --home-dir /data -M --shell /sbin/nologin --uid $UIDS -g radicale radicale

# make sure we can write to data & config & socket
chown -R $UIDS:$GIDS /data /config /socket || { echo 'Unable to read/write data folder' ; exit 1; }
chmod -R o= /data

exec /opt/pypy/bin/gunicorn -c /config/gunicorn.py -u radicale -g radicale --env 'RADICALE_CONFIG=/config/radicale.conf' radicale

#!/bin/sh
# make sure we can write to config
if [ ! -w "/config/" ]
then
	echo "Unable to read or write config directory!"
	exit 1

elif [ ! -r "/config/radicale.conf" ]
then
	echo "No config detected/readable. Please put a config file into the config directory"
	exit 1
fi

# make sure we can write to data
usermod -u $UIDS radicale
groupmod -g $GIDS radicale

chown -R $UIDS:$GIDS /data || { echo 'Unable to read/write data folder' ; exit 1; }

exec /usr/sbin/gosu radicale '/opt/pypy/bin/radicale --config /config/radicale.conf'

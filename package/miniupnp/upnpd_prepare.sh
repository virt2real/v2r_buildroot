#!/bin/sh
IFACE=$1
DEVID=`cat /etc/virt2real/deviceid`
cat /etc/miniupnpd.conf | sed 's/listening_ip=.*/listening_ip='$IFACE'/}' | sed 's/friendly_name=.*/friendly_name='$DEVID' (Virt2real)/}' | sed 's/model_description=.*/model_description='$DEVID'/}'> /etc/miniupnpd.conf.new
mv /etc/miniupnpd.conf.new /etc/miniupnpd.conf
killall miniupnpd 2>&1 > /dev/null
/usr/bin/miniupnpd -i $IFACE

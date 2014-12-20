#!/bin/sh
IFACE=$1
DEVID=`cat /etc/virt2real/deviceid`
cat /etc/miniupnpd.conf | sed "s|listening_ip=.*|listening_ip=$IFACE|g" | sed "s|friendly_name=.*|friendly_name=$DEVID (Virt2real)|g" | sed "s|model_description=.*|model_description=$DEVID|g"> /etc/miniupnpd.conf.new
if [ $? = 0 ] ; then
	mv /etc/miniupnpd.conf.new /etc/miniupnpd.conf
	killall miniupnpd 2>&1 > /dev/null
	/usr/bin/miniupnpd -i $IFACE
fi

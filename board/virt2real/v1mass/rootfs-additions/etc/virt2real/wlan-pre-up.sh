#!/bin/sh

IFACE=$1

# Check uEnv parameter "ap=on"
AP=`cat /proc/cmdline | grep "ap=on"`
if [ ! "$AP" == "" ] ; then 
	# if access point mode - return
	exit 0
fi

if [ -e  /var/run/wpa_supplicant/$IFACE ] ; then
	rm /var/run/wpa_supplicant/$IFACE
fi

nice -n -20 /usr/sbin/wpa_supplicant -D wext -i$IFACE -c /etc/wpa_supplicant.conf -B
/usr/sbin/wpa_cli -i$IFACE -a /etc/virt2real/wlanchanged.sh -B

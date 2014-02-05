#!/bin/sh

SSIDFILE=/tmp/ssid
IFACE=$1

case "$2" in

CONNECTED)
	SSID=`/usr/sbin/wpa_cli status | /bin/grep "ssid=" | /usr/bin/awk 'BEGIN {FS="="} { if ($1=="ssid") print $2}'`
	echo $SSID > $SSIDFILE
	/etc/virt2real/log "connected to Wi-Fi $SSID"
	/etc/virt2real/setlight.sh red on
;;

DISCONNECTED)
	/etc/virt2real/setlight.sh red off
	echo "" > $SSIDFILE
	/etc/virt2real/log "disconnected from Wi-Fi \"$SSID\""
;;

esac

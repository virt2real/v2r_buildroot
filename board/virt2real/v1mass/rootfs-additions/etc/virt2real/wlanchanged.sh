#!/bin/sh

echo "WI-FI: " $1 $2

case "$2" in
DISCONNECTED)
	/etc/virt2real/setlight.sh red off
;;

CONNECTED)
	#ifup $1
	/etc/virt2real/setlight.sh red on
;;
esac


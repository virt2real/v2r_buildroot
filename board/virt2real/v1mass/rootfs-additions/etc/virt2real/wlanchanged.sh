#!/bin/sh

case "$2" in

CONNECTED)
	ifdown $1
	ifup $1
	/etc/virt2real/setlight.sh red on
;;

DISCONNECTED)
	/etc/virt2real/setlight.sh red off
;;

esac


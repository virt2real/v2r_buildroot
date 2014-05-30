#!/bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin/X11:/usr/local/bin

IFACE=$1

/etc/virt2real/log "$IFACE down"
/sbin/ifdown -f $IFACE

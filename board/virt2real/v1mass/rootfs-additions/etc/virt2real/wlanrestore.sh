#!/bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin/X11:/usr/local/bin

IFACE=wlan0

/etc/virt2real/log "$IFACE restored"
/usr/bin/killall udhcpc
/sbin/ifup -f $IFACE

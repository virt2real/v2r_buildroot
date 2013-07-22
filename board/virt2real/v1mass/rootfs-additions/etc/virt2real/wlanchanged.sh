#!/bin/sh

echo "WI-FI: " $1 $2

case "$2" in
DISCONNECTED)
    /etc/virt2real/setlight.sh green off
;;

CONNECTED)
    #ifup $1
    /etc/virt2real/setlight.sh green on
;;
esac


#!/bin/sh

VALUE=0
case "$2" in
on)
	VALUE=1
	;;
off)
	VALUE=0
	;;
1)
	VALUE=1
	;;
0)
	VALUE=0
	;;
esac

case "$1" in
green)
        echo "set gpio73 output:$VALUE" > /dev/v2r_gpio
        echo "Set green $VALUE"
	;;
red)
        echo "set gpio74 output:$VALUE" > /dev/v2r_gpio
        echo "Set green $VALUE"
	;;
esac

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
        echo "set gpio 73 output $VALUE" > /dev/v2r_gpio
        echo "set green $VALUE"
	;;
red)
        echo "set gpio 74 output $VALUE" > /dev/v2r_gpio
        echo "set red $VALUE"
	;;
blue)
        echo "set rto 3 $VALUE" > /dev/v2r_gpio
        echo "set blue $VALUE"
	;;
esac

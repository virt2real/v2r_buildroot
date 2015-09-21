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
        echo "set blue $VALUE"
        echo $VALUE > /proc/v2r_gpio/pwctr3
        ;;
debuggreen)
        echo "set debug green $VALUE"
        echo $VALUE > /proc/v2r_pins/77
        ;;
debugred)
        echo "set debug red $VALUE"
        echo $VALUE > /proc/v2r_pins/75
        ;;
debugblue)
        echo "set debug blue $VALUE"
        echo $VALUE > /proc/v2r_pins/78
        ;;
debugyellow)
        echo "set debug yellow $VALUE"
        echo $VALUE > /proc/v2r_pins/80
        ;;
rj45yellow)
        echo "set debug yellow $VALUE"
        echo $VALUE > /proc/v2r_pins/63
        ;;
rj45green)
        echo "set debug yellow $VALUE"
        echo $VALUE > /proc/v2r_pins/64
        ;;
esac

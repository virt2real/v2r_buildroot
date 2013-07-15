#!/bin/sh

VALUE=0
case "$2" in
on)
	VALUE=1
	;;
off)
	VALUE=0
	;;
esac

case "$1" in
green)
	echo 73 > /sys/class/gpio/export
	echo "out" > /sys/class/gpio/gpio73/direction
	echo "Set green $VALUE"
	echo $VALUE > /sys/class/gpio/gpio73/value
	echo 73 > /sys/class/gpio/unexport
	;;
red)
	echo 74 > /sys/class/gpio/export
	echo "out" > /sys/class/gpio/gpio74/direction
	echo "Set red $VALUE"
	echo $VALUE > /sys/class/gpio/gpio74/value
	echo 74 > /sys/class/gpio/unexport
	;;
esac

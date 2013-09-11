#!/bin/sh

# mount debugfs
mount -t debugfs debugfs /sys/kernel/debug

# start 1-wire modules
#modprobe wire.ko
#modprobe w1-gpio.ko
#modprobe w1_therm.ko


# turn on wi-fi don't sleep script
/etc/virt2real/dontsleep.sh &

# path for NodeJS global modules
export NODE_PATH=/usr/lib/node_modules

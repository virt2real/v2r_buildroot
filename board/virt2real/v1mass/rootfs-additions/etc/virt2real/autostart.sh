#!/bin/sh

# mount debugfs
mount -t debugfs debugfs /sys/kernel/debug

# path for NodeJS global modules
export NODE_PATH=/usr/lib/node_modules

# set sound volume
/usr/bin/amixer set "Mono DAC" 63 > /dev/null

# add broadcast route
/sbin/ip route add 224.0.0.0/4 dev wlan0

# camera flip
#i2cset -f -y 1 0x30 0x12 0x39

# TCP/IP tune
sysctl -w net.ipv4.tcp_congestion_control=lp > /dev/null
sysctl -w net.ipv4.tcp_fastopen=1 > /dev/null
sysctl -w net.ipv4.tcp_slow_start_after_idle=0 > /dev/null
ifconfig wlan0 txqueuelen 5000 > /dev/null


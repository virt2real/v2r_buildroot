#!/bin/sh

modprobe lib80211.ko

# start drivers initialization
/etc/virt2real/wlan.sh

# config interface for fixed IP address
ifconfig wlan0 192.168.2.1
#/sbin/ifup wlan0 -f

hostapd /etc/hostapd/hostapd.conf -B

# set tx power auto level
#iw dev wlan0 set txpower fixed 100
iw dev wlan0 set txpower auto

/etc/virt2real/log "hostapd: access point created"

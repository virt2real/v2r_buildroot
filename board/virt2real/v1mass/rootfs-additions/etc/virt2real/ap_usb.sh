#!/bin/sh

# config interface
ifup wlan0 -f

hostapd /etc/hostapd/hostapd.conf -B

/etc/virt2real/log "hostapd: access point created"

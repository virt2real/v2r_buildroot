#!/bin/sh

IFACE=$1

# Check uEnv parameter "ap=on"
AP=`cat /proc/cmdline | grep "ap=on"`
if [ ! "$AP" == "" ] ; then 
	# if access point mode - return
	exit 0
fi

SED=/usr/bin/sed

if [ -e  /var/run/wpa_supplicant/$IFACE ] ; then
    rm /var/run/wpa_supplicant/$IFACE
fi

# get ssid from cmdline
SSID=`cat /proc/cmdline |  $SED 's/ /\n/g' | grep wifi_ssid | $SED 's/wifi_ssid=//g'`

# get psk from cmdline
PASS=`cat /proc/cmdline |  $SED 's/ /\n/g' | grep wifi_pass | $SED 's/wifi_pass=//g'`

if [ "$SSID" != "" ] ; then
    if [ "$PASS" != "" ] ; then
	# save current wpa_supplicant.conf
	cp /etc/wpa_supplicant.conf /etc/wpa_supplicant.old
	# change ssid and psk in wpa_supplicant.conf        
	cat /etc/wpa_supplicant.old | $SED '0,/ssid=".*"/{s/ssid=".*"/ssid="'$SSID'"/}' | $SED '0,/psk=".*"/{s/psk=".*"/psk="'$PASS'"/}' > /etc/wpa_supplicant.conf
    fi
fi

# run wpa_supplicant and wpa_cli
nice -n -20 /usr/sbin/wpa_supplicant -D wext -i$IFACE -c /etc/wpa_supplicant.conf -B
/usr/sbin/wpa_cli -i$IFACE -a /etc/virt2real/wlanchanged.sh -B

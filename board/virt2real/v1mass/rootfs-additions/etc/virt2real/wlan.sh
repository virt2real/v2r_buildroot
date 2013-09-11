#!/bin/sh
modprobe libertas
modprobe libertas_sdio
sleep 5
/usr/sbin/wpa_supplicant -Dwext -iwlan0 -c /etc/wpa_supplicant.conf -B
/usr/sbin/wpa_cli -B -a /etc/virt2real/wlanchanged.sh


ifconfig wlan0 192.168.1.128

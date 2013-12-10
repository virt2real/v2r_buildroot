#!/bin/sh

INTERFACE=wlan0

# load wireless modules drivers

# Check uEnv parameter " wifi=on" (with leading space) - legacy wi-fi
CMDLINE=`cat /proc/cmdline | grep " wifi=on"`
if [ ! "$CMDLINE" == "" ]; then

    # virt2real legacy WiFi
    modprobe libertas
    modprobe libertas_sdio

fi

# Check uEnv parameter " usbwifi=on" (with leading space) - USB wi-fi
CMDLINE=`cat /proc/cmdline | grep " usbwifi=on"`
if [ ! "$CMDLINE" == "" ]; then

    # USB WiFi

    #ASUS USB-N53
    modprobe rt2800usb.ko

    #ASUS USB-N13
    modprobe rtl8192cu.ko

    #Upvel UA-214NU
    modprobe rt2800usb.ko

    #ASUS USB-N10
    modprobe r8712u.ko  

fi

# wait for driver loading

QUIT=0
COUNTER=0
while [ $QUIT = 0 ]
do
  CMDLINE=`cat /proc/net/wireless | grep $INTERFACE`
  if [ ! "$CMDLINE" == "" ]; then
    /usr/sbin/wpa_supplicant -D wext -iwlan0 -c /etc/wpa_supplicant.conf -B
    /usr/sbin/wpa_cli -B -a /etc/virt2real/wlanchanged.sh
    QUIT=1
    exit 0
  fi
  let "COUNTER = COUNTER + 1"
  if [ $COUNTER = 10 ] ;
  then
    QUIT=1
    exit 1       
  fi
  sleep 1
done

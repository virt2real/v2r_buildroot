#!/bin/sh

INTERFACE=wlan0

modprobe lib80211.ko

# load wireless modules drivers

# Check uEnv parameter " wifi=on" (with leading space) - legacy wi-fi
CMDLINE=`cat /proc/cmdline | grep " wifi=on"`
if [ ! "$CMDLINE" == "" ] ; then

    # virt2real legacy WiFi
    modprobe libertas
    modprobe libertas_sdio
    
    #modprobe libertas_tf.ko 
    #modprobe libertas_tf_sdio.ko

fi

# Check uEnv parameter " usbwifi=on" (with leading space) - USB wi-fi
CMDLINE=`cat /proc/cmdline | grep " usbwifi=on"`
if [ ! "$CMDLINE" == "" ] ; then

    # USB WiFi

    #ASUS USB-N53
    modprobe rt2800usb.ko
    #insmod /rt3572sta.ko

    #ASUS USB-N13
    modprobe rtl8192cu.ko

    #Upvel UA-214NU
    modprobe rt2800usb.ko

    #ASUS USB-N10
    modprobe r8712u.ko

fi

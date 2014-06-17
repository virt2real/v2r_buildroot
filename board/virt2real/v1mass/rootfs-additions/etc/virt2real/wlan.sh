#!/bin/sh

INTERFACE=wlan0

# load wireless modules drivers

# Check uEnv parameter " wifi=on" (with leading space) - legacy wi-fi
CMDLINE=`cat /proc/cmdline | grep " wifi=on"`
if [ ! "$CMDLINE" == "" ] ; then

    # virt2real legacy WiFi

echo 1 > /proc/v2r_gpio/59
echo 1 > /proc/v2r_gpio/60

    modprobe libertas
    modprobe libertas_sdio
    
    #modprobe libertas_tf.ko 
    #modprobe libertas_tf_sdio.ko

fi

# Check uEnv parameter " usbwifi=on" (with leading space) - USB wi-fi
CMDLINE=`cat /proc/cmdline | grep " usbwifi=on"`
if [ ! "$CMDLINE" == "" ] ; then

    # USB WiFi

    #ASUS USB-N53 and D-link DWA-160 rev.B2 (and many others)
    insmod /lib/modules/3.9.0-rc6-virt2real+/kernel/drivers/net/wireless/rt5572sta.ko

    #ASUS USB-N13
    modprobe rtl8192cu.ko

    #Upvel UA-214NU
    modprobe rt2800usb.ko

    #ASUS USB-N10
    modprobe r8712u.ko

fi

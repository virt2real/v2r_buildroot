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
    # add ASUS USB-N53 VID:PID
    echo 0b05 179d > /sys/bus/usb/drivers/rt2870/new_id

    #TP-link TL-WN725N
    insmod /lib/modules/3.9.0-rc6-virt2real+/kernel/drivers/net/wireless/8188eu.ko

    #ASUS USB-N13
    insmod /lib/modules/3.9.0-rc6-virt2real+/kernel/drivers/net/wireless/8192cu.ko

    #Upvel UA-214NU
    #modprobe rt2800usb.ko

    #ASUS USB-N10
    #modprobe r8712u.ko

    # Add devices width different VID:PID

    # add TP-LINK TL-WN8200ND
    echo 2357 0100 > /sys/bus/usb/drivers/rtl8192cu/new_id
    echo 0bda 8176 > /sys/bus/usb/drivers/rtl8192cu/new_id

fi

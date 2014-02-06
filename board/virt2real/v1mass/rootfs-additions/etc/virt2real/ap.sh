#!/bin/sh

# check config file param ($1)

if [ "$1" == "" ] ; then
  echo "AccessPoint: empty config file param"
  exit 1
fi

# get params from configuration file
SSID=`cat $1 | grep SSID | awk 'BEGIN {FS="="} {print $2}'`
PASSPHRASE=`cat $1 | grep PASSPHRASE | awk 'BEGIN {FS="="} {print $2}'`

if [ "$SSID" == "" ] ; then
  echo "AccessPoint: empty SSID param"
  exit 1
fi

if [ "$PASSPHRASE" == "" ] ; then
  echo "AccessPoint: empty PASSPHRASE param"
  exit 1
fi

modprobe lib80211.ko

# load Marvell SoftAP driver module
modprobe uap8xxx.ko

# config interface
ifup uap0 -f

# start Marvell SoftAP daemon
uaputl sys_cfg_ssid "$SSID"
uaputl sys_cfg_protocol 32
uaputl sys_cfg_wpa_passphrase "$PASSPHRASE"
uaputl sys_cfg_cipher 8 8
uaputl sys_cfg_channel 0 1
uaputl bss_start

/etc/virt2real/log "uaputl: access point created"

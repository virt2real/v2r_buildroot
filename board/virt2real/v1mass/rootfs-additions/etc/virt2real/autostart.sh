#!/bin/sh

# mount debugfs
mount -t debugfs debugfs /sys/kernel/debug

# start 1-wire modules
#modprobe wire.ko
#modprobe w1-gpio.ko
#modprobe w1_therm.ko

# turn on wi-fi don't sleep script
/etc/virt2real/dontsleep.sh &

# path for NodeJS global modules
export NODE_PATH=/usr/lib/node_modules

#modprobe bma180.ko
#modprobe bmp085.ko
#modprobe hmc5843.ko
#modprobe itg3200.ko
#modprobe adxl34x.ko
#modprobe adxl34x-i2c.ko

#echo bmp085 0x77 > /sys/class/i2c-adapter/i2c-1/new_device
#echo bma180 0x40 > /sys/class/i2c-adapter/i2c-1/new_device
#echo hmc5843 0x1e > /sys/class/i2c-adapter/i2c-1/new_device
#echo itg3200 0x68 > /sys/class/i2c-adapter/i2c-1/new_device
#echo adxl34x 0x53 > /sys/class/i2c-adapter/i2c-1/new_device

# set sound volume
/usr/bin/amixer set "Mono DAC" 63 > /dev/null


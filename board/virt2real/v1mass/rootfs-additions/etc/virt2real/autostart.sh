#!/bin/sh

# mount debugfs
mount -t debugfs debugfs /sys/kernel/debug

# start 1-wire modules
#modprobe wire.ko
#modprobe w1-gpio.ko
#modprobe w1_therm.ko

# for i2c sensors
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


# turn on wi-fi don't sleep script
/etc/virt2real/dontsleep.sh &

# path for NodeJS global modules
export NODE_PATH=/usr/lib/node_modules

# set sound volume
/usr/bin/amixer set "Mono DAC" 63 > /dev/null

# add broadcast route
/sbin/ip route add 224.0.0.0/4 dev wlan0

# for motorshield
#echo "set gpio 83 output 0" > /dev/v2r_gpio
#echo "set gpio 84 output 0" > /dev/v2r_gpio
#echo v2r_extpwm 0x40 > /sys/class/i2c-adapter/i2c-1/new_device

# camera flip
#i2cset -f -y 1 0x30 0x12 0x39

#cd /var/www/modules/armdrive/server
#./run.sh &

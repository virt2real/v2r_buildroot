#!/bin/sh

echo "set con 63 output 1" > /dev/v2r_pins
echo "set con 63 output 0" > /dev/v2r_pins

echo "set con 64 output 1" > /dev/v2r_pins
echo "set con 64 output 0" > /dev/v2r_pins

echo "heartbeat" > /sys/class/leds/lan:green:user/trigger
echo "heartbeat" > /sys/class/leds/lan:yellow:user/trigger

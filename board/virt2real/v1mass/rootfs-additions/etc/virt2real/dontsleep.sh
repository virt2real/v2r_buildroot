#!/bin/sh

while [ 1 ]
do
ifconfig wlan0 > /dev/null
sleep 600
done


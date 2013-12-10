#!/bin/sh
while [ 1 ]
do
sleep 60
ifconfig wlan0 > /dev/null
done


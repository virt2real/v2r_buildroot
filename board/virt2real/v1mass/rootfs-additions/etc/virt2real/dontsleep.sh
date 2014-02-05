#!/bin/sh

GATEWAY=`/sbin/ip route | /bin/grep default | /usr/bin/awk 'BEGIN {FS=" "} {print $3}'`

while [ 1 ]
do
	/bin/sleep 60
	/bin/ping -c 3 $GATEWAY > /dev/null 2>&1
done


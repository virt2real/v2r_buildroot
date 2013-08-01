#!/bin/sh

HOST=`cat /etc/resolv.conf | awk 'BEGIN {} {print $2}'`

while [ 1 ]
do
ping $HOST -c1 > /dev/null
sleep 60
done


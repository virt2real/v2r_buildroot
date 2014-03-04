#!/bin/sh

# interface to check
IFACE=wlan0

# host to check
HOST=192.168.1.2

# time interval
TIMEOUT=60

# maximum ping errors befor reboot
# if 0 - do not reboot
MAXPINGERROR=5

# current ping errors counter
COUNTER=0

# current module retries counter
MODCOUNTER=0


# restart wlan modules
restart_module() {

	rmmod libertas_sdio
	rmmod libertas
	
	modprobe libertas
	modprobe libertas_sdio

}

# check wlan interface
check_interface() {
	iw $IFACE info > /dev/null 2>&1
	if [ ! $? == 0 ] ; then
		let MODCOUNTER=MODCOUNTER+1
		echo $MODCOUNTER > /tmp/watchdog.mod
		restart_module
	fi

}

# ping selected host
check_ping() {
	/bin/ping -c 2 $HOST > /dev/null 2>&1

	if [ ! $? == 0 ] ; then

		let COUNTER=COUNTER+1

		check_interface

	else
		let COUNTER=0
	fi

	if [ ! $MAXPINGERROR -eq 0 ] ; then
		if [ $COUNTER -ge $MAXPINGERROR ] ; then
			reboot -f
		fi
	fi

	echo $COUNTER > /tmp/watchdog.ping
}

# run at start
check_ping

# run endless by TIMEOUT
while [ 1 ]
do
	/bin/sleep $TIMEOUT
	check_ping
done


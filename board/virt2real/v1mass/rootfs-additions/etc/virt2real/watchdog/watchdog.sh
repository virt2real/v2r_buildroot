#!/bin/sh

DIR=/etc/virt2real/watchdog
TMPDIR=/tmp

# interface to check
IFACE=`cat $DIR/iface`

# host to check
HOST=`cat $DIR/host`

# time interval
TIMEOUT=`cat $DIR/timeout`

# maximum ping errors befor reboot
# if 0 - do not reboot
MAXPINGERROR=`cat $DIR/maxpingerrors`

# current ping errors counter
COUNTER=0

# current module retries counter
MODCOUNTER=0

# restart modules
restart_module() {

	$DIR/restartmodule.sh

}

# check wlan interface
check_interface() {
	iw $IFACE info > /dev/null 2>&1
	if [ ! $? == 0 ] ; then
		let MODCOUNTER=MODCOUNTER+1
		echo $MODCOUNTER > $TMPDIR/watchdog.mod
		restart_module
	fi

}

# ping selected host
check_ping() {
	/bin/ping -c 2 -I $IFACE $HOST > /dev/null 2>&1

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

	echo $COUNTER > $TMPDIR/watchdog.ping
}

# run at start
check_ping

# run endless by TIMEOUT
while [ 1 ]
do
	/bin/sleep $TIMEOUT
	check_ping
done

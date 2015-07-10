#!/bin/sh
# started from /etc/init.d/S21usb if current USB mode is "client"

echo USB client mode

# run DHCP server for usb0 interface
echo -n "Starting DHCP server: "
test ! -d /var/lib/dhcp/ && mkdir -p /var/lib/dhcp/
test ! -f /var/lib/dhcp/dhcpd.leases && touch /var/lib/dhcp/dhcpd.leases
test ! -f /etc/dhcpd.conf && ln -s /etc/dhcp/dhcpd.conf /etc/dhcpd.conf > /dev/null
test -f /var/run/dhcpd.pid && rm /var/run/dhcpd.pid > /dev/null
start-stop-daemon -S -x /usr/sbin/dhcpd  -q usb0

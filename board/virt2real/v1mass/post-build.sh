#!/bin/sh

TARGETDIR=$1
BOARDDIR=board/virt2real/v1mass

# Set root password to 'root'. Password generated with
# mkpasswd, from the 'whois' package in Debian/Ubuntu.
sed -i 's%root::%root:8kfIfYHmcyQEE:%' $TARGETDIR/etc/shadow

# Remove bad files
rm $TARGETDIR/etc/resolv.conf
rm $TARGETDIR/etc/init.d/S01logging

# Copy the rootfs additions
cp -r $BOARDDIR/rootfs-additions/* $TARGETDIR/

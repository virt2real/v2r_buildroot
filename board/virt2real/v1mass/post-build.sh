#!/bin/sh

TARGETDIR=$1
BOARDDIR=board/virt2real/v1mass

# Set root password to 'root'. Password generated with
# mkpasswd, from the 'whois' package in Debian/Ubuntu.
sed -i 's%root::%root:8kfIfYHmcyQEE:%' $TARGETDIR/etc/shadow

# Copy the rootfs additions
sudo cp -r $BOARDDIR/rootfs-additions/* $TARGETDIR/

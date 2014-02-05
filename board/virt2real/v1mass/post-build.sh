#!/bin/sh

TARGETDIR=$1
BOARDDIR=board/virt2real/v1mass

# Set root password to 'root'. Password generated with
# mkpasswd, from the 'whois' package in Debian/Ubuntu.
sed -i 's%root::%root:8kfIfYHmcyQEE:%' $TARGETDIR/etc/shadow

# Remove bad files
rm $TARGETDIR/etc/resolv.conf

# Remove docs
if [ -d $TARGETDIR/usr/share/gtk-doc ] ; then
    rm -R $TARGETDIR/usr/share/gtk-doc
fi

if [ -d $TARGETDIR/usr/share/docs ] ; then
    rm -R $TARGETDIR/usr/share/docs
fi

# Remove unused locale
locales=`ls --ignore="ru" --ignore="en*" $TARGETDIR/usr/share/locale`
for i in $locales ; do
    rm -R $TARGETDIR/usr/share/locale/$i
done

# Copy the rootfs additions
cp -R $BOARDDIR/rootfs-additions/* $TARGETDIR/

#!/bin/sh

WWW_ROOT=/var/www/admin

# remove all previews from admin panel
/etc/virt2real/log "clear all thumbnails for USB media device..."
rm -f $WWW_ROOT/modules/gphotoview/thumbnails/*
/etc/virt2real/log "all thumbnails for USB media device cleared"

# If its still mounted, then dismount it
if grep -qs "/media/camera " /proc/mounts ; then
      umount /media/camera
      /etc/virt2real/log "USB media device unmounted"
fi

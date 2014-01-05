#!/bin/sh

# remove all previews from admin panel
echo "clear all thumbnails for USB media device..." > /tmp/systemmessage
rm -f /var/www/modules/gphotoview/thumbnails/*
echo "all thumbnails for USB media device cleared" > /tmp/systemmessage

# If its still mounted, then dismount it
if grep -qs '/media/camera ' /proc/mounts; then
      umount /media/camera
      echo "USB media device unmounted" > /tmp/systemmessage
fi

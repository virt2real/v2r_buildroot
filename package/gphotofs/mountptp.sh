#!/bin/sh

echo "found USB media device" > /tmp/systemmessage

#Make Directory if it doesn't exist
if [ ! -d /media/camera ]; then
      /bin/mkdir /media/camera
fi

# If something already mounted, dismount it
if grep -qs '/media/camera ' /proc/mounts; then
      /bin/umount /media/camera
fi

# Mount the camera
/usr/bin/gphotofs /media/camera
if [ $? == 0 ] ; then
    echo "USB media device mounted" > /tmp/systemmessage
else
    echo "" > /tmp/systemmessage
    exit 1
fi

# load previews for admin panel
cd /var/www/modules/gphotoview/thumbnails
echo "loading USB media device thumbnails..." > /tmp/systemmessage

yes | gphoto2 --get-all-thumbnails
if [ $? == 0 ] ; then
    echo "USB media device thumbnails loaded" > /tmp/systemmessage
    echo 'if (LoadDir) LoadDir("", "/var/www/modules/gphotoview/thumbnails");' > /tmp/systemaction
else
    echo "" > /tmp/systemmessage
    exit 1
fi

MANUFACTURER=`gphoto2 --get-config /main/status/manufacturer | grep Current | sed  's%Current: %%' `
MODEL=`gphoto2 --get-config /main/status/cameramodel  | grep Current | sed  's%Current: %%' `
echo $MANUFACTURER $MODEL connected > /tmp/systemmessage

exit 0

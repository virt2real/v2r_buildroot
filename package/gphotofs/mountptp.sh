#!/bin/sh

WWW_ROOT=/var/www/admin
THUMB_DIR=$WWW_ROOT/modules/gphotoview/thumbnails
CAMERA_DIR=/media/camera
CAMERA_LINK=$WWW_ROOT/modules/usbmediadevices/camera

/etc/virt2real/log "found USB media device"

#Make Directory if it doesn't exist
if [ ! -d $CAMERA_DIR ] ; then
    mkdir -p $CAMERA_DIR
fi


# If something already mounted, dismount it
if grep -qs "$CAMERA_DIR" /proc/mounts ; then
    /bin/umount $CAMERA_DIR
fi

# Mount the camera
gphotofs $CAMERA_DIR
if [ $? == 0 ] ; then
    /etc/virt2real/log "USB media device mounted"
else
    exit 1
fi

@ln -s $CAMERA_DIR $CAMERA_LINK

# load previews for admin panel

if [ ! -d $THUMB_DIR ] ; then
    mkdir -p $THUMB_DIR
fi

cd $THUMB_DIR

/etc/virt2real/log "loading USB media device thumbnails..."

yes | gphoto2 --get-all-thumbnails
#if [ $? == 0 ] ; then
#    /etc/virt2real/log "USB media device thumbnails loaded"
#else
#    exit 1
#fi

MANUFACTURER=`gphoto2 --get-config /main/status/manufacturer | grep Current | sed  's%Current: %%' `
MODEL=`gphoto2 --get-config /main/status/cameramodel  | grep Current | sed  's%Current: %%' `
/etc/virt2real/log "$MANUFACTURER $MODEL connected"

exit 0

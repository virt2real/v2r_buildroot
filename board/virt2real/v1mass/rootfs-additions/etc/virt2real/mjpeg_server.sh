#!/bin/sh

WIDTH=`cat /etc/virt2real/video.width`
HEIGHT=`cat /etc/virt2real/video.height`
BITRATE=`cat /etc/virt2real/video.bitrate`
FPS=`cat /etc/virt2real/video.fps`
PITCHSTR=`cat /etc/virt2real/video.pitch`
if [ ! "$PITCHSTR" = "" ] ; then
	PITCH=",pitch=$PITCHSTR"
fi

. /etc/virt2real/mjpeg_server.conf

case "$1" in
start)
	/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
    gst-launch v4l2src always-copy=false chain-ipipe=true ! \
	capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT,framerate='(fraction)'$FPS$PITCH ! \
	    dmaiaccel ! \
	    dmaienc_mjpeg qValue=$QUALITY copyOutput=false outputBufferSize=0 fixTimestamp=true ! \
	    tcpserversink port=$PORT sync=false > /dev/null &
	echo "MJPEG" > /tmp/onair
	;;

stop)
	/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
	echo "" > /tmp/onair
	;;
esac

exit 0

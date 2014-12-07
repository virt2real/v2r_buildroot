#!/bin/sh

WIDTH=`cat /etc/virt2real/video.width`
HEIGHT=`cat /etc/virt2real/video.height`
BITRATE=`cat /etc/virt2real/video.bitrate`
FPS=`cat /etc/virt2real/video.fps`
PITCHSTR=`cat /etc/virt2real/video.pitch`
if [ ! "$PITCHSTR" = "" ] ; then
	PITCH=",pitch=$PITCHSTR"
fi

. /etc/virt2real/rtmp_client.conf

case "$1" in
start)
	/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
	gst-launch v4l2src always-copy=false chain-ipipe=true ! \
		capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT,framerate='(fraction)'$FPS$PITCH ! \
		dmaiaccel ! \
		dmaienc_h264 copyOutput=false ddrbuf=false encodingpreset=2 ratecontrol=1 intraframeinterval=30 idrinterval=120 t8x8intra=true t8x8inter=true targetbitrate=$BITRATE bytestream=false headers=false ! \
		flvmux name=mux streamable=true ! \
		rtmpsink location="$LOCATION" sync=false enable-last-buffer=false > /dev/null &
	echo "RTMP" > /tmp/onair
	;;

stop)
	/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
	echo "" > /tmp/onair
	;;
esac

exit 0

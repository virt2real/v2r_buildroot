#!/bin/sh

WIDTH=`cat /etc/virt2real/video.width`
HEIGHT=`cat /etc/virt2real/video.height`
BITRATE=`cat /etc/virt2real/video.bitrate`
FPS=`cat /etc/virt2real/video.fps`
PITCHSTR=`cat /etc/virt2real/video.pitch`
if [ ! "$PITCHSTR" = "" ] ; then
	PITCH=",pitch=$PITCHSTR"
fi

. /etc/virt2real/rtsp_server.conf

case "$1" in
start)
	
	if [ "$VERSION" == "1" ] ;
	then
		/usr/bin/killall rtsp-server > /dev/null 2>&1
		/usr/bin/rtsp-server $PORT $PATH "( v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT$PITCH ! dmaiaccel ! dmaienc_h264 ddrbuf=false copyOutput=false outputBufferSize=1500000 targetbitrate=$BITRATE encodingpreset=2 ratecontrol=2 intraframeinterval=30 idrinterval=60 bytestream=true ! rtph264pay pt=96 name=pay0 mtu=3000 config-interval=0 perfect-rtptime=false scan-mode=1 )" > /dev/null &
	else
		/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
		/usr/bin/gst-launch v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT$PITCH ! queue ! dmaiaccel ! dmaienc_h264 ddrbuf=false copyOutput=false outputBufferSize=1500000 targetbitrate=$BITRATE encodingpreset=2 ratecontrol=2 intraframeinterval=30 idrinterval=60 bytestream=true ! queue ! rtspsink mapping="$PATH" service="$PORT" > /dev/null &
	fi
	echo "RTSP" > /tmp/onair

	;;

stop)
	/usr/bin/killall rtsp-server > /dev/null 2>&1
	/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
	echo "" > /tmp/onair
	;;
esac

exit 0

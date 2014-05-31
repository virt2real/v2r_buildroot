#!/bin/sh

# check default values
if [ "$2" == "" ] ;
then
	PORT=554
else
	PORT=$2
fi

if [ "$3" == "" ] ;
then
	PATH=/video
else
	PORT=$3
fi

if [ "$4" == "" ] ;
then
	BITRATE=1000000
else
	BITRATE=$4
fi

if [ "$5" == "" ] ;
then
	VERSION=1
else
	VERSION=$5
fi



case "$1" in
start)
	

	while [ 1 ] ;
	do
		echo "RTSP" > /tmp/onair
		if [ "$VERSION" == "1" ] ;
		then
			killall test-launch > /dev/null 2>&1
			rtsp-server $PORT $PATH "( v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,width=1280,height=720 ! queue ! dmaiaccel ! dmaienc_h264 ddrbuf=false copyOutput=false outputBufferSize=1500000 targetbitrate=$BITRATE encodingpreset=2 ratecontrol=1 intraframeinterval=23 idrinterval=46 level=41 qpintra=25 qpinter=25 bytestream=true ! rtph264pay pt=96 name=pay0 mtu=3000 config-interval=0 perfect-rtptime=false scan-mode=1 )"
		else
			killall gst-launch-0.10 > /dev/null 2>&1
			gst-launch v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,format='(fourcc)'NV12, width=1280, height=720, framerate='(fraction)'30/1 ! queue ! dmaiaccel ! dmaienc_h264 ddrbuf=false copyOutput=false outputBufferSize=9000000 targetbitrate=$BITRATE encodingpreset=2 ratecontrol=2 intraframeinterval=10 idrinterval=20 level=41 ! queue ! rtspsink mapping="$PATH" service="$PORT"
		fi
		echo "" > /tmp/onair

		sleep 10
	done

	;;

stop)
	killall rtsp-server > /dev/null 2>&1
	killall gst-launch-0.10 > /dev/null 2>&1
	echo "" > /tmp/onair
	;;
esac
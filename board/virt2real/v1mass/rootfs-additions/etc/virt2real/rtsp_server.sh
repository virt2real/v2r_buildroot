#!/bin/sh
 
VERSION=2
 
while [ 1 ] ; 
do
 
	if [ "$VERSION" == "1" ] ; 
	then
		killall test-launch > /dev/null 2>&1
		nice -n -10 test-launch "( v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,width=1280,height=720 ! dmaiaccel ! dmaienc_h264 ddrbuf=true copyOutput=false outputBufferSize=9000000 targetbitrate=1000000 ! rtph264pay pt=96 name=pay0  config-interval=1 )"
	else
		killall gst-launch-0.10 > /dev/null 2>&1
		nice -n -10 gst-launch v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,format='(fourcc)'NV12, width=1280, height=720, framerate='(fraction)'30/1 ! dmaiaccel ! dmaienc_h264 ddrbuf=true copyOutput=false outputBufferSize=9000000 targetbitrate=700000 encodingpreset=2 ratecontrol=2 intraframeinterval=23 idrinterval=46 ! rtspsink mapping="/test"
	fi
 
	sleep 10
 
done

#!/bin/sh

VERSION=1

while [ 1 ] ; 
do

	if [ "$VERSION" == "1" ] ; 
	then
		killall test-launch > /dev/null 2>&1
		nice -n -10 test-launch "( v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,width=640,height=480 ! dmaiaccel ! dmaienc_h264 ddrbuf=true copyOutput=false outputBufferSize=9000000 targetbitrate=1000000 ! rtph264pay pt=96 name=pay0 )"
	else
		killall gst-launch-0.10 > /dev/null 2>&1
		nice -n -10 gst-launch v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,format='(fourcc)'NV12, width=640, height=480, framerate='(fraction)'30/1 ! dmaiaccel ! dmaienc_h264 ddrbuf=true copyOutput=false outputBufferSize=9000000 targetbitrate=1000000 ! rtspsink mapping="/test" service=8554
	fi

	sleep 10

done

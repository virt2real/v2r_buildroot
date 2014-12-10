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

rtmp_no_sound()
{
	gst-launch v4l2src always-copy=false chain-ipipe=true ! \
		capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT,framerate='(fraction)'$FPS$PITCH ! \
		dmaiaccel ! \
		dmaienc_h264 copyOutput=false ddrbuf=false encodingpreset=2 ratecontrol=2 single-nalu=true targetbitrate=$BITRATE maxbitrate=$BITRATE level=51 intraframeinterval=150 idrinterval=250 t8x8intra=true t8x8inter=true bytestream=false headers=false ! \
		flvmux name=mux streamable=true ! \
		queue ! \
		rtmpsink location="$LOCATION live=1" sync=false enable-last-buffer=false > /dev/null &
}

rtmp_sound()
{
	gst-launch v4l2src always-copy=false chain-ipipe=true ! \
		capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT,framerate='(fraction)'$FPS$PITCH ! \
		dmaiaccel ! \
		dmaienc_h264 copyOutput=false ddrbuf=false encodingpreset=2 ratecontrol=2 single-nalu=true targetbitrate=$BITRATE maxbitrate=4000000 level=51 intraframeinterval=150 idrinterval=250 t8x8intra=true t8x8inter=true bytestream=false headers=false ! \
		queue ! \
		flvmux streamable=true name=mux \
		alsasrc latency-time=200000 buffer-time=4000000 slave-method=3 do-timestamp=false provide-clock=false ! \
		capsfilter caps=audio/x-raw-int,channels=1,rate=16000,endianness=1234,signed=true,width=16,depth=16 ! \
		queue ! \
		dmaienc_aac bitrate=48000 maxbitrate=48000 tns=false copyOutput=false outputBufferSize=500000 fullbandwidth=true fixTimestamp=true ! \
		mux. \
		mux. ! \
		queue ! \
		rtmpsink location="$LOCATION live=1" sync=false enable-last-buffer=false > /dev/null &
}

case "$1" in
start)
	/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
	if [ "$SOUND" = "1" ] ; then
		rtmp_sound
	else
		rtmp_no_sound
	fi
	echo "RTMP" > /tmp/onair
	;;

stop)
	/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
	echo "" > /tmp/onair
	;;
esac

exit 0

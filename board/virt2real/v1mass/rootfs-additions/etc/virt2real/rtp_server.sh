#!/bin/sh

WIDTH=`cat /etc/virt2real/video.width`
HEIGHT=`cat /etc/virt2real/video.height`
BITRATE=`cat /etc/virt2real/video.bitrate`
FPS=`cat /etc/virt2real/video.fps`
PITCHSTR=`cat /etc/virt2real/video.pitch`
if [ ! "$PITCHSTR" = "" ] ; then
	PITCH=",pitch=$PITCHSTR"
fi

. /etc/virt2real/rtp_server.conf

run()
{
	case "$TYPE" in
		GST)
			/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
			gst-launch v4l2src always-copy=false chain-ipipe=true ! \
				capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT,framerate='(fraction)'$FPS$PITCH ! \
				dmaiaccel ! dmaienc_h264 copyOutput=false ddrbuf=false encodingpreset=2 ratecontrol=2 intraframeinterval=30 idrinterval=120 t8x8intra=true t8x8inter=true targetbitrate=$BITRATE bytestream=true headers=false ! \
				rtph264pay mtu=30000 ! \
				multiudpsink clients="$CLIENTS" sync=false enable-last-buffer=false > /dev/null &
			echo "RTP Gst" > /tmp/onair
		;;
		ANDROID)
			/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
			gst-launch v4l2src always-copy=false chain-ipipe=true ! \
				capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT,framerate='(fraction)'$FPS$PITCH ! \
				dmaiaccel ! dmaienc_h264 copyOutput=false ddrbuf=false encodingpreset=2 ratecontrol=2 intraframeinterval=30 idrinterval=120 t8x8intra=true t8x8inter=true targetbitrate=$BITRATE bytestream=true headers=false ! \
				multiudpsink clients="$CLIENTS" sync=false enable-last-buffer=false > /dev/null &
			echo "RTP Android" > /tmp/onair
		;;
		IOS)
			/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
			gst-launch v4l2src always-copy=false chain-ipipe=true ! \
				capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT,framerate='(fraction)'$FPS$PITCH ! \
				dmaiaccel ! dmaienc_h264 copyOutput=false ddrbuf=false encodingpreset=2 ratecontrol=2 intraframeinterval=30 idrinterval=60 t8x8intra=true t8x8inter=true targetbitrate=$BITRATE bytestream=false headers=true ! \
				rtph264pay mtu=1444 ! \
				multiudpsink clients="$CLIENTS" sync=false enable-last-buffer=false >/dev/null &
			echo "RTP IOS" > /tmp/onair
		;;
	esac
}

case "$1" in
start)
	run
	;;

stop)
	/usr/bin/killall -INT gst-launch-0.10 > /dev/null 2>&1
	echo "" > /tmp/onair
	;;
esac

exit 0

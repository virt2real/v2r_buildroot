#!/bin/sh

CLIENTS="192.168.1.101:3000"

WIDTH=`cat /etc/virt2real/video.width`
HEIGHT=`cat /etc/virt2real/video.height`
FPS=`cat /etc/virt2real/video.fps`
BITRATE=`cat /etc/virt2real/video.bitrate`
PITCHSTR=`cat /etc/virt2real/video.pitch`
if [ ! "$PITCHSTR" = "" ] ; then
	PITCH=",pitch=$PITCHSTR"
fi

gst-launch v4l2src always-copy=false chain-ipipe=true ! \
	capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=$WIDTH,height=$HEIGHT,framerate='(fraction)'$FPS$PITCH ! \
	dmaiaccel ! dmaienc_h264 copyOutput=false ddrbuf=false encodingpreset=2 ratecontrol=2 intraframeinterval=30 idrinterval=120 t8x8intra=true t8x8inter=true targetbitrate=$BITRATE bytestream=true headers=false ! \
	multiudpsink clients=$CLIENTS sync=false enable-last-buffer=false

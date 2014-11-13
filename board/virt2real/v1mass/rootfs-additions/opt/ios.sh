#!/bin/sh
gst-launch v4l2src always-copy=false chain-ipipe=true ! capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=1280,height=720,framerate='(fraction)'30 ! dmaiaccel ! dmaienc_h264 copyOutput=false ddrbuf=false encodingpreset=2 ratecontrol=1 intraframeinterval=30 idrinterval=60 t8x8intra=true t8x8inter=true airrate=30 targetbitrate=1000000 bytestream=false headers=true ! rtph264pay mtu=1500 pt=96 ! multiudpsink clients="192.168.1.10:3000,192.168.1.20:3000" sync=false enable-last-buffer=false



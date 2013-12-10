#!/bin/sh
HOST=192.168.1.10

gst-launch v4l2src always-copy=false chain-ipipe=true ! \
    video/x-raw-yuv,format='(fourcc)'NV12, width=640, height=480, framerate='(fraction)'30/1 ! \
    dmaiaccel ! \
    dmaienc_h264 ddrbuf=true encodingpreset=2 ratecontrol=4 targetbitrate=600000 ! \
    rtph264pay !  queue ! \
    udpsink port=3000 host=$HOST sync=false


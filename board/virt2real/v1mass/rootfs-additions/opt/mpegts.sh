#GST_DEBUG=3,*rtmp*:5  \
gst-launch v4l2src always-copy=false chain-ipipe=true decimate=1 ! \
    video/x-raw-yuv,format='(fourcc)'NV12, width=640, height=480, framerate='(fraction)'30/1 ! \
    dmaiaccel ! \
    dmaienc_h264 ddrbuf=true encodingpreset=2 ratecontrol=4 targetbitrate=600000 ! \
    queue ! \
    ffmux_mpegts name=mux ! \
    udpsink port=10000 host=0.0.0.0 sync=false



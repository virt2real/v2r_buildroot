#############################################################
#
# SoX
#
#############################################################
GST_RTSP_SERVER_VERSION = 0.10.8
GST_RTSP_SERVER_SITE = http://gstreamer.freedesktop.org/src/gst-rtsp-server/
GST_RTSP_SERVER_SOURCE = gst-rtsp-$(GST_RTSP_SERVER_VERSION).tar.bz2

GST_RTSP_SERVER_DEPENDENCIES = gstreamer

$(eval $(autotools-package))

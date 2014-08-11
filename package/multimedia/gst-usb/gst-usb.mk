#############################################################
#
# gst-usb
#
#############################################################
GST_USB_VERSION = HEAD
GST_USB_SITE = http://github.com/RidgeRun/gst-plugin-usb/tarball/$(GST_USB_VERSION)
GST_USB_AUTORECONF = YES

GST_USB_DEPENDENCIES = gstreamer gst-plugins-base

$(eval $(autotools-package))

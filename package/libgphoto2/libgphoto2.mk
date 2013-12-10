#############################################################
#
# LIBGPHOTO2
#
#############################################################

LIBGPHOTO2_VERSION = 2.5.2
LIBGPHOTO2_SOURCE = libgphoto2-$(LIBGPHOTO2_VERSION).tar.gz
LIBGPHOTO2_SITE = http://optimate.dl.sourceforge.net/project/gphoto/libgphoto/2.5.2/
LIBGPHOTO2_INSTALL_STAGING = YES
LIBGPHOTO2_INSTALL_TARGET = NO
LIBGPHOTO2_CONF_OPT = --enable-static
LIBGPHOTO2_DEPENDENCIES = libusb-compat libtool

$(eval $(autotools-package))

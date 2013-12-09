#############################################################
#
# GPHOTO2
#
#############################################################

GPHOTO2_VERSION = 2.5.2
GPHOTO2_SOURCE = gphoto2-$(GPHOTO2_VERSION).tar.gz
GPHOTO2_SITE = http://optimate.dl.sourceforge.net/project/gphoto/gphoto/2.5.2/
GPHOTO2_INSTALL_STAGING = YES
GPHOTO2_INSTALL_TARGET = YES
GPHOTO2_DEPENDENCIES = host-libgphoto2 libusb-compat libgphoto2
GPHOTO2_CONF_ENV += LDFLAGS+="-lgphoto2"

$(eval $(autotools-package))
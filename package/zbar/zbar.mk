#############################################################
#
# zbar
#
#############################################################

ZBAR_VERSION = HEAD
ZBAR_SITE = http://github.com/ZBar/ZBar/tarball/$(V4L2GRAB_VERSION)
ZBAR_INSTALL_TARGET = YES
ZBAR_AUTORECONF = YES
ZBAR_DEPENDENCIES = libv4l
ZBAR_CONF_OPT = --without-imagemagick --without-qt --without-gtk --without-python --without-x --without-jpeg --enable-shared=yes
#--enable-pthread=no 

define ZBAR_INSTALL_TARGET_CMDS

	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/usr/lib
	$(INSTALL) -m 0755 $(@D)/zbar/.libs/libzbar.so.* $(TARGET_DIR)/usr/lib
	$(INSTALL) -m 0755 $(@D)/zbarcam/zbarcam $(TARGET_DIR)/usr/bin
endef

define ZBAR_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/lib/libzbar.so.*
endef

$(eval $(autotools-package))

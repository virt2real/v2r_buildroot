#############################################################
#
# GPHOTOFS
#
#############################################################

GPHOTOFS_VERSION = 0.5
GPHOTOFS_SOURCE = gphotofs-$(GPHOTOFS_VERSION).tar.gz
GPHOTOFS_SITE = http://citylan.dl.sourceforge.net/project/gphoto/gphotofs/0.5.0/
GPHOTOFS_INSTALL_STAGING = YES
GPHOTOFS_INSTALL_TARGET = YES
GPHOTOFS_DEPENDENCIES = libusb-compat libfuse libgphoto2 udev
GPHOTOFS_CONF_OPT = --with-libgphoto2=$(STAGING_DIR)/usr

define GPHOTOFS_INSTALL_UDEV
	mkdir -p $(TARGET_DIR)/etc/udev/rules.d
	mkdir -p $(TARGET_DIR)/usr/bin
        # $(HOST_DIR)/usr/lib/libgphoto2/print-camera-list udev-rules version 175 mode 0660 > $(TARGET_DIR)/etc/udev/rules.d/40-gphoto.rules
        cat package/gphotofs/40-gphoto.rules >> $(TARGET_DIR)/etc/udev/rules.d/40-gphoto.rules
        $(INSTALL) -m 0755 package/gphotofs/mountptp.sh $(TARGET_DIR)/usr/bin/mountptp.sh
        $(INSTALL) -m 0755 package/gphotofs/umountptp.sh $(TARGET_DIR)/usr/bin/umountptp.sh
endef

GPHOTOFS_POST_INSTALL_TARGET_HOOKS += GPHOTOFS_INSTALL_UDEV

$(eval $(autotools-package))
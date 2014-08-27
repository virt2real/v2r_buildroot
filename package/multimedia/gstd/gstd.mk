#############################################################
#
# gstd
#
#############################################################

GSTD_VERSION = HEAD
GSTD_SITE = http://github.com/RidgeRun/gstd/tarball/$(GSTD_VERSION)
GSTD_INSTALL_TARGET = YES
GSTD_AUTORECONF = YES
GSTD_DEPENDENCIES = host-pkgconf host-vala dbus gstreamer gst-plugins-base
GSTD_CONF_OPT = --with-vapidir=$(TARGET_DIR)/usr/share/vala-0.26/vapi/

define GSTD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/dbus-1/system.d
	mkdir -p $(TARGET_DIR)/etc/init.d
	$(INSTALL) -m 0666 package/multimedia/gstd/gstd.conf $(TARGET_DIR)/etc/dbus-1/system.d
	$(INSTALL) -m 0755 package/multimedia/gstd/S31gstd $(TARGET_DIR)/etc/init.d

	mkdir -p $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/src/gstd $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/src/gst-client $(TARGET_DIR)/usr/bin
endef

define GSTD_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/etc/dbus-1/system.d/gstd.conf
	rm -f $(TARGET_DIR)/etc/init.d/S31gstd
	rm -f $(TARGET_DIR)/usr/bin/gstd
	rm -f $(TARGET_DIR)/usr/bin/gst-client
endef

$(eval $(autotools-package))

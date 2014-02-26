#############################################################
#
# gstd
#
#############################################################

GSTD_VERSION = HEAD
GSTD_SITE = http://github.com/RidgeRun/gstd/tarball/$(GSTD_VERSION)
GSTD_INSTALL_TARGET = YES
GSTD_AUTORECONF = YES
GSTD_DEPENDENCIES = host-pkgconf host-vala dbus
GSTD_CONF_OPT = --with-vapidir=$(TARGET_DIR)/usr/share/vala-0.18/vapi/

define GSTD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/dbus-1/system.d
	$(INSTALL) -m 0755 package/multimedia/gstd/gstd.conf $(TARGET_DIR)/etc/dbus-1/system.d
endef

define PROFTPD_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/etc/dbus-1/system.d/gstd.conf
endef

$(eval $(autotools-package))

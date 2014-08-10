#############################################################
#
# opkg
#
#############################################################

OPKG_VERSION = 635
OPKG_SOURCE = opkg-$(OPKG_VERSION).tar.gz
OPKG_SITE = http://opkg.googlecode.com/svn/trunk/
OPKG_SITE_METHOD = svn
OPKG_INSTALL_STAGING = YES
OPKG_CONF_OPT = --disable-curl --disable-gpg
OPKG_AUTORECONF = YES
# Uses PKG_CHECK_MODULES() in configure.ac
OPKG_DEPENDENCIES = host-pkgconf

HOST_OPKG_AUTORECONF = YES
HOST_OPKG_DEPENDENCIES = host-pkgconf
HOST_OPKG_CONF_OPT = --disable-curl --disable-gpg


# Ensure directory for lockfile exists
define OPKG_CREATE_LOCKDIR
	mkdir -p $(TARGET_DIR)/usr/lib/opkg

	mkdir -p $(TARGET_DIR)/etc/opkg
	$(INSTALL) -m 0755 package/opkg/opkg.conf $(TARGET_DIR)/etc/opkg/

endef

OPKG_POST_INSTALL_TARGET_HOOKS += OPKG_CREATE_LOCKDIR

$(eval $(autotools-package))
$(eval $(host-autotools-package))

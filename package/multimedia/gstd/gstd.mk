#############################################################
#
# gstd
#
#############################################################

GSTD_VERSION = HEAD
GSTD_SITE = http://github.com/RidgeRun/gstd/tarball/$(GSTD_VERSION)
#GSTD_INSTALL_STAGING = YES
GSTD_INSTALL_TARGET = YES
GSTD_AUTORECONF = YES
GSTD_DEPENDENCIES = host-pkgconf host-vala dbus
GSTD_CONF_OPT = --with-vapidir=$(TARGET_DIR)/usr/share/vala-0.18/vapi/

$(eval $(autotools-package))

#############################################################
#
# ipiped
#
#############################################################

IPIPED_VERSION = HEAD
IPIPED_SITE = http://github.com/RidgeRun/ipiped/tarball/$(IPIPED_VERSION)
IPIPED_INSTALL_TARGET = YES
GSTD_DEPENDENCIES = host-pkgconf host-vala dbus
GSTD_CONF_OPT = --with-vapidir=$(TARGET_DIR)/usr/share/vala-0.26/vapi/

$(eval $(autotools-package))

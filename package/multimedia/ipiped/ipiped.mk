#############################################################
#
# ipiped
#
#############################################################

IPIPED_VERSION = HEAD
IPIPED_SITE = http://github.com/RidgeRun/ipiped/tarball/$(IPIPED_VERSION)
#IPIPED_INSTALL_STAGING = YES
IPIPED_INSTALL_TARGET = YES
IPIPED_AUTORECONF = YES
IPIPED_DEPENDENCIES = host-pkgconf host-vala
IPIPED_CONF_OPT = --with-vapidir=$(TARGET_DIR)/usr/share/vala-0.18/vapi/

$(eval $(autotools-package))

################################################################################
#
# ipiped
#
################################################################################

IPIPED_VERSION = HEAD
IPIPED_SITE = http://github.com/RidgeRun/ipiped/tarball/$(IPIPED_VERSION)
IPIPED_INSTALL_STAGING = YES
IPIPED_DEPENDENCIES = gstreamer host-pkgconf

$(eval $(autotools-package))

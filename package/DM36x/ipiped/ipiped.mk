#############################################################
#
# ipiped
#
#############################################################

IPIPED_VERSION = HEAD
IPIPED_SITE = http://github.com/RidgeRun/ipiped/tarball/$(IPIPED_VERSION)
IPIPED_LICENSE = BSD
IPIPED_LICENSE_FILES = COPYING

$(eval $(autotools-package))

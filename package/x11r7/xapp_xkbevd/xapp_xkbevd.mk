################################################################################
#
# xapp_xkbevd -- XKB event daemon
#
################################################################################

XAPP_XKBEVD_VERSION = 1.1.3
XAPP_XKBEVD_SOURCE = xkbevd-$(XAPP_XKBEVD_VERSION).tar.bz2
XAPP_XKBEVD_SITE = http://xorg.freedesktop.org/releases/individual/app
XAPP_XKBEVD_LICENSE = MIT
XAPP_XKBEVD_LICENSE_FILES = COPYING
XAPP_XKBEVD_DEPENDENCIES = xlib_libxkbfile

$(eval $(autotools-package))

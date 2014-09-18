################################################################################
#
# miredo
#
################################################################################

MIREDO_VERSION = 1.2.6
MIREDO_SITE = http://www.remlab.net/files/miredo
MIREDO_SOURCE = miredo-$(MIREDO_VERSION).tar.xz
MIREDO_AUTORECONF = YES
MIREDO_CONF_OPT += --disable-binreloc

$(eval $(autotools-package))

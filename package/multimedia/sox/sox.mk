#############################################################
#
# SoX
#
#############################################################
SOX_VERSION = 14.4.1
SOX_SITE = http://downloads.sourceforge.net/project/sox/sox/$(SOX_VERSION)
SOX_SOURCE = sox-$(SOX_VERSION).tar.bz2
SOX_CONF_OPT += --disable-external-gsm

$(eval $(autotools-package))

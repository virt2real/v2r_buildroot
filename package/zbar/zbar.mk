#############################################################
#
# zbar
#
#############################################################

ZBAR_VERSION = HEAD
ZBAR_SITE = http://github.com/ZBar/ZBar/tarball/$(V4L2GRAB_VERSION)
ZBAR_INSTALL_TARGET = YES
ZBAR_INSTALL_STAGING = YES
ZBAR_AUTORECONF = YES
ZBAR_DEPENDENCIES = libv4l
ZBAR_CONF_OPT = --without-imagemagick --without-qt --without-gtk --without-python --without-x --without-jpeg --enable-shared=yes
#--enable-pthread=no 

ZBAR_POST_BUILD_HOOKS += ZBAR_INSTALL_FIXUP

define ZBAR_INSTALL_FIXUP
	touch $(@D)/doc/man/zbarcam.1
endef

$(eval $(autotools-package))

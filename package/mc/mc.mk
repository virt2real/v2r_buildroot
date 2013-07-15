#############################################################
#
# mc
#
#############################################################
MC_VERSION = 4.8.8
MC_SITE = http://ftp.midnight-commander.org/
MC_SOURCE = mc-$(MC_VERSION).tar.bz2
MC_DEPENDENCIES += ncurses libglib2
MC_CONF_OPT += \
	--with-screen=ncurses \
	#--with-ncurses-libs=$(STAGING_DIR)/usr/lib \
	#--with-ncurses-includes=$(STAGING_DIR)/usr/include \
	--without-x \
	--with-subshell \
	--disable-rpath

ifneq ($(BR2_LARGEFILE),y)
	MC_CONF_OPT += --disable-largefile
endif

$(eval $(autotools-package))

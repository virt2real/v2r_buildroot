#############################################################
#
# pjsip
#
#############################################################

PJSIP_VERSION = 2.3
PJSIP_SOURCE = pjproject-$(PJSIP_VERSION).tar.bz2
PJSIP_SITE = http://www.pjsip.org/release/$(PJSIP_VERSION)/
PJSIP_INSTALL_STAGING = YES
PJSIP_DEPENDENCIES = util-linux
PJSIP_CONF_OPT = --with-sysroot=$(STAGING_DIR) 

PJSIP_CONF_ENV = \
    CFLAGS="$(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS)" \
    CXXFLAGS="$(TARGET_CFLAGS) $(EXTRA_CFLAGS) $(TARGET_CPPFLAGS) $(EXTRA_CPPFLAGS)" \
    LDFLAGS="$(TARGET_LDFLAGS) $(EXTRA_LDFLAGS) $(LIBGCC_S) -lm" 

$PJSIP_MAKE_ENV = $(PJSIP_CONF_ENV)

$(eval $(autotools-package))

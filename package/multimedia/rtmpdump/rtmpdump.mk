#############################################################
#
# rtmpdump
#
#############################################################

RTMPDUMP_VERSION = b627335
RTMPDUMP_SITE = http://sources.openelec.tv/devel
RTMPDUMP_SOURCE = rtmpdump-$(RTMPDUMP_VERSION).tar.xz
RTMPDUMP_INSTALL_STAGING = YES
RTMPDUMP_INSTALL_TARGET = YES

RTMPDUMP_DEPENDENCIES = zlib openssl

RTMPDUMP_SRCDIR = $(RTMPDUMP_DIR)/librtmp
RTMPDUMP_MAKE_OPT = \
    prefix=/usr \
    incdir=/usr/include/librtmp \
    libdir=/usr/lib \
    mandir=/usr/share/man \
    CC="$(TARGET_CC)" \
    LD="$(TARGET_LD)" \
    AR="$(TARGET_AR)" \
    CRYPTO="OPENSSL" \
    XCFLAGS="$(TARGET_CFLAGS) $(TARGET_LDFLAGS)"

RTMPDUMP_INSTALL_STAGING_OPT = \
    $(RTMPDUMP_MAKE_OPT) DESTDIR=$(STAGING_DIR) install

RTMPDUMP_INSTALL_TARGET_OPT = \
    $(RTMPDUMP_MAKE_OPT) DESTDIR=$(TARGET_DIR) install

define RTMPDUMP_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) $(RTMPDUMP_MAKE_OPT) -C $(RTMPDUMP_SRCDIR)
endef

define RTMPDUMP_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) $(RTMPDUMP_INSTALL_STAGING_OPT) -C $(RTMPDUMP_SRCDIR)
endef

define RTMPDUMP_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) $(MAKE) $(RTMPDUMP_INSTALL_TARGET_OPT) -C $(RTMPDUMP_SRCDIR)
endef

$(eval $(generic-package))

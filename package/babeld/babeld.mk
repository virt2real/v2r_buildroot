################################################################################
#
# babeld
#
################################################################################

BABELD_VERSION = HEAD
BABELD_SITE = http://github.com/jech/babeld/tarball/$(BABELD_VERSION)
BABELD_INSTALL_STAGING = YES
BABELD_INSTALL_TARGET = YES

BABELD_PLATFORM = dm365

define BABELD_BUILD_CMDS
        $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" -C $(@D)
endef

define BABELD_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/babeld $(TARGET_DIR)/usr/sbin/babeld
endef

$(eval $(generic-package))

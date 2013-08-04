UAPUTL_VERSION = HEAD
UAPUTL_SITE = http://github.com/virt2real/uaputl/tarball/$(UAPUTL_VERSION)

define UAPUTL_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define UAPUTL_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/uaputl $(TARGET_DIR)/usr/bin/uaputl
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/share/uaputl
    $(INSTALL) -D -m 0644 $(@D)/config/* $(TARGET_DIR)/usr/share/uaputl/
endef

$(eval $(generic-package))

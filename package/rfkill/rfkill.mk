#############################################################
#
# rfkill
#
#############################################################

RFKILL_VERSION = 0.5
RFKILL_SOURCE = rfkill-$(RFKILL_VERSION).tar.gz
RFKILL_SITE = https://www.kernel.org/pub/software/network/rfkill/

define RFKILL_BUILD_CMDS
        $(MAKE) -C $(@D) CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define RFKILL_INSTALL_TARGET_CMDS
        install -m 0755 -D $(@D)/rfkill $(TARGET_DIR)/usr/bin/rfkill
endef

define RFKILL_INSTALL_TARGET_CMDS
#	$(MAKE) -C $(@D)
	cp -a $(@D)/rfkill $(TARGET_DIR)/usr/bin/rfkill
endef

define RFKILL_CLEAN_CMDS
#	$(MAKE) -C $(@D) clean
	rm -f $(TARGET_DIR)/usr/bin/rfkill
endef


$(eval $(generic-package))
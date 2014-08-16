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
	mkdir -p $(TARGET_DIR)/usr/bin
	cp -a $(@D)/rfkill $(TARGET_DIR)/usr/bin/rfkill
endef

define RFKILL_CLEAN_CMDS
	rm -f $(TARGET_DIR)/usr/bin/rfkill
endef


$(eval $(generic-package))
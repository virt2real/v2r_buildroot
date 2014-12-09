#############################################################
#
# uflash
#
#############################################################

UFLASH_VERSION = HEAD
UFLASH_SITE = http://github.com/virt2real/othersoft/tarball/$(UFLASH_VERSION)

define UFLASH_BUILD_CMDS
        $(MAKE) -C $(@D)/uflash CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define UFLASH_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/etc/virt2real/ubl
	$(INSTALL) -m 0755 -D $(@D)/uflash/uflash $(TARGET_DIR)/usr/bin/uflash
	$(INSTALL) -D $(DEVDIR)/dvsdk/psp/board_utilities/serial_flash/dm365/*.bin $(TARGET_DIR)/etc/virt2real/ubl/
	$(INSTALL) -D $(DEVDIR)/uboot/u-boot.bin $(TARGET_DIR)/etc/virt2real/ubl/
endef

define UFLASH_CLEAN_CMDS
	rm -f $(TARGET_DIR)/usr/bin/uflash
	rm -f $(TARGET_DIR)/etc/virt2real/ubl
endef

$(eval $(generic-package))
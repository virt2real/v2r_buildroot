#############################################################
#
# i2c_write
#
#############################################################

I2C_WRITE_VERSION = HEAD
I2C_WRITE_SITE = http://github.com/virt2real/othersoft/tarball/$(I2C_WRITE_VERSION)

define I2C_WRITE_BUILD_CMDS
        $(MAKE) -C $(@D)/i2c_write CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define I2C_WRITE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 -D $(@D)/i2c_write/i2c_write $(TARGET_DIR)/usr/bin/i2c_write
	$(INSTALL) -m 0755 -D $(@D)/i2c_write/i2c_check $(TARGET_DIR)/usr/bin/i2c_check
endef

define I2C_WRITE_CLEAN_CMDS
	rm -f $(TARGET_DIR)/usr/bin/i2c_write
	rm -f $(TARGET_DIR)/usr/bin/i2c_check
endef

$(eval $(generic-package))
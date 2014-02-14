NODEJS_MODULES_VERSION = HEAD
NODEJS_MODULES_SITE = http://github.com/virt2real/virt2real_nodejs_modules/tarball/$(NODEJS_MODULES_VERSION)

define NODEJS_MODULES_INSTALL_TARGET_CMDS

	mkdir -p $(TARGET_DIR)/usr/lib/node_modules/virt2real
	mkdir -p $(TARGET_DIR)/usr/lib/node_modules/motorshield
	cp -R $(@D)/virt2real/* $(TARGET_DIR)/usr/lib/node_modules/virt2real/
	cp -R $(@D)/motorshield/* $(TARGET_DIR)/usr/lib/node_modules/motorshield/

endef

define NODEJS_MODULES_UNINSTALL_TARGET_CMDS
	rm -Rf $(TARGET_DIR)/usr/lib/node_modules/virt2real
	rm -Rf $(TARGET_DIR)/usr/lib/node_modules/motorshield
endef

$(eval $(generic-package))

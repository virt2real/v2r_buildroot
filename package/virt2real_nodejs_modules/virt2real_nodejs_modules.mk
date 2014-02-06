VIRT2REAL_NODEJS_MODULES_VERSION = HEAD
#VIRT2REAL_NODEJS_MODULES_SITE = http://github.com/virt2real/gstreamer-dmai/tarball/$(VIRT2REAL_NODEJS_MODULES_VERSION)
VIRT2REAL_NODEJS_MODULES_SITE = http://github.com/virt2real/virt2real_nodejs_modules/tarball/$(VIRT2REAL_NODEJS_MODULES_VERSION)
#https://github.com/virt2real/virt2real_nodejs_modules.git

#define VIRT2REAL_NODEJS_MODULES_EXTRACT_CMDS
#	cp $(DL_DIR)/$(VIRT2REAL_NODEJS_MODULES_SOURCE) $(@D)
#endef

define VIRT2REAL_NODEJS_MODULES_INSTALL_TARGET_CMDS

	mkdir -p $(TARGET_DIR)/usr/lib/node_modules/virt2real
	mkdir -p $(TARGET_DIR)/usr/lib/node_modules/motorshield
	cp -R $(@D)/virt2real/* $(TARGET_DIR)/usr/lib/node_modules/virt2real/
	cp -R $(@D)/motorshield/* $(TARGET_DIR)/usr/lib/node_modules/motorshield/

endef

define VIRT2REAL_NODEJS_MODULES_UNINSTALL_TARGET_CMDS
	rm -Rf $(TARGET_DIR)/usr/lib/node_modules/virt2real
	rm -Rf $(TARGET_DIR)/usr/lib/node_modules/motorshield
endef

$(eval $(generic-package))

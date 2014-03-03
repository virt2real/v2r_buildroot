TELEGUEJS_VERSION = HEAD
TELEGUEJS_SITE = http://github.com/virt2real/telegue_nodejs/tarball/$(TELEGUEJS_VERSION)

define TELEGUEJS_INSTALL_TARGET_CMDS

	mkdir -p $(TARGET_DIR)/opt
	mkdir -p $(TARGET_DIR)/etc/init.d
	cp -R $(@D)/teleguejs $(TARGET_DIR)/opt/
	cp -R $(@D)/S98teleguejs $(TARGET_DIR)/etc/init.d

endef

define TELEGUEJS_UNINSTALL_TARGET_CMDS
	rm -Rf $(TARGET_DIR)/opt/teleguejs
	rm -Rf $(TARGET_DIR)/etc/init.d/S98teleguejs
endef

$(eval $(generic-package))

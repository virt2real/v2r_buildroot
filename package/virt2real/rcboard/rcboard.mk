#############################################################
#
# rcboard
#
#############################################################

RCBOARD_VERSION = HEAD
RCBOARD_SITE = http://github.com/virt2real/rcboard/tarball/$(RCBOARD_VERSION)
RCBOARD_DEPENDENCIES = libconfuse libcurl

define RCBOARD_BUILD_CMDS
        $(MAKE) -C $(@D)/board CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define RCBOARD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/rcboard
	mkdir -p $(TARGET_DIR)/etc/init.d.sample
	$(INSTALL) -m 0755 -D $(@D)/board/rcboard $(TARGET_DIR)/opt/rcboard/
	$(INSTALL) -m 0755 -D $(@D)/board/scripts/*.sh $(TARGET_DIR)/opt/rcboard/
	$(INSTALL) -m 0644 -D $(@D)/board/scripts/rcboard.conf $(TARGET_DIR)/opt/rcboard/
	$(INSTALL) -m 0755 package/virt2real/rcboard/S98rcboard $(TARGET_DIR)/etc/init.d.sample/
endef

define RCBOARD_CLEAN_CMDS
	rm -f $(TARGET_DIR)/opt/rcboard/rcboard
	rm -f $(TARGET_DIR)/opt/rcboard/*
	rm -f $(TARGET_DIR)/etc/init.d.sample/S98rcboard
endef

$(eval $(generic-package))
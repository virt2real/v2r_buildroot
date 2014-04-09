#############################################################
#
# gpio-event
#
#############################################################

GPIO_EVENT_VERSION = HEAD
GPIO_EVENT_SITE = http://github.com/virt2real/othersoft/tarball/$(GPIO_EVENT_VERSION)

define GPIO_EVENT_BUILD_CMDS
        $(MAKE) -C $(@D)/gpio-event CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define GPIO_EVENT_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
        install -m 0755 -D $(@D)/gpio-event/gpio-event $(TARGET_DIR)/usr/bin/gpio-event
        install -m 0755 -D $(@D)/gpio-event/usrange $(TARGET_DIR)/usr/bin/usrange
endef

define GPIO_EVENT_CLEAN_CMDS
	rm -f $(TARGET_DIR)/usr/bin/gpio-event
	rm -f $(TARGET_DIR)/usr/bin/usrange
endef

$(eval $(generic-package))
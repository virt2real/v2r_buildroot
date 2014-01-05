#############################################################
#
# miniupnpc
#
#############################################################

MINIUPNPC_VERSION = 1.8
MINIUPNPC_SOURCE = miniupnpc-$(MINIUPNPC_VERSION).tar.gz
MINIUPNPC_SITE = http://miniupnp.free.fr/files

define MINIUPNPC_BUILD_CMDS
        $(MAKE) -C $(@D) CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define MINIUPNPC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
        install -m 0755 -D $(@D)/upnpc-static $(TARGET_DIR)/usr/bin/upnpc
endef

define MINIUPNPC_INSTALL_TARGET_CMDS
#	$(MAKE) -C $(@D)
	mkdir -p $(TARGET_DIR)/usr/bin
	cp -a $(@D)/upnpc-static $(TARGET_DIR)/usr/bin/upnpc
endef

define MINIUPNPC_CLEAN_CMDS
#	$(MAKE) -C $(@D) clean
	rm -f $(TARGET_DIR)/usr/bin/upnpc
endef


$(eval $(generic-package))
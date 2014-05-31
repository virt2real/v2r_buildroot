#############################################################
#
# rtsp-server
#
#############################################################

RTSP_SERVER_VERSION = HEAD
RTSP_SERVER_SITE = http://github.com/virt2real/othersoft/tarball/$(RTSP_SERVER_VERSION)

define RTSP_SERVER_BUILD_CMDS
        $(MAKE) -C $(@D)/rtsp-server CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define RTSP_SERVER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/etc/virt2real
	$(INSTALL) -m 0755 -D $(@D)/rtsp-server/rtsp-server $(TARGET_DIR)/usr/bin/rtsp-server
	$(INSTALL) -m 0755 package/virt2real/rtsp-server/rtsp_server.sh $(TARGET_DIR)/etc/virt2real/rtsp_server.sh
endef

define RTSP_SERVER_CLEAN_CMDS
	rm -f $(TARGET_DIR)/usr/bin/rtsp-server
	rm -f $(TARGET_DIR)/etc/virt2real/rtsp_server.sh
endef

$(eval $(generic-package))
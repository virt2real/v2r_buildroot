#############################################################
#
# rtsp-server
#
#############################################################

RTSP_SERVER_VERSION = HEAD
RTSP_SERVER_SITE = http://github.com/virt2real/othersoft/tarball/$(RTSP_SERVER_VERSION)
RTSP_SERVER_DEPENDENCIES = gst-rtsp-server

define RTSP_SERVER_BUILD_CMDS
        $(MAKE) -C $(@D)/rtsp-server CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define RTSP_SERVER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/etc/virt2real
	mkdir -p $(TARGET_DIR)/etc/init.d.sample
	$(INSTALL) -m 0755 -D $(@D)/rtsp-server/rtsp-server $(TARGET_DIR)/usr/bin/rtsp-server
	$(INSTALL) -m 0755 package/virt2real/rtsp-server/rtsp_server.sh $(TARGET_DIR)/etc/virt2real/rtsp_server.sh
	$(INSTALL) -m 0755 package/virt2real/rtsp-server/S92rtspserver $(TARGET_DIR)/etc/init.d.sample/S92rtspserver
endef

define RTSP_SERVER_CLEAN_CMDS
	rm -f $(TARGET_DIR)/usr/bin/rtsp-server
	rm -f $(TARGET_DIR)/etc/virt2real/rtsp_server.sh
	rm -f $(TARGET_DIR)/etc/init.d.sample/S92rtspserver
endef

$(eval $(generic-package))
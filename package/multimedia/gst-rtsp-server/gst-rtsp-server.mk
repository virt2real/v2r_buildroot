#############################################################
#
# RTSP Server
#
#############################################################
GST_RTSP_SERVER_VERSION = 0.10.8
GST_RTSP_SERVER_SITE = http://gstreamer.freedesktop.org/src/gst-rtsp-server/
GST_RTSP_SERVER_SOURCE = gst-rtsp-$(GST_RTSP_SERVER_VERSION).tar.bz2
GST_RTSP_SERVER__INSTALL_TARGET = YES

GST_RTSP_SERVER_DEPENDENCIES = gstreamer gst-plugins-base

define GST_RTSP_SERVER_INSTALL_TARGET_CMDS
        mkdir -p $(TARGET_DIR)/usr/bin
        mkdir -p $(TARGET_DIR)/usr/lib
        $(INSTALL) -m 0755 $(@D)/examples/test-launch $(TARGET_DIR)/usr/bin
        $(INSTALL) -m 0755 $(@D)/examples/test-auth $(TARGET_DIR)/usr/bin
        $(INSTALL) -m 0755 $(@D)/examples/test-mp4 $(TARGET_DIR)/usr/bin
        $(INSTALL) -m 0755 $(@D)/examples/test-ogg $(TARGET_DIR)/usr/bin
        $(INSTALL) -m 0755 $(@D)/examples/test-sdp $(TARGET_DIR)/usr/bin
        $(INSTALL) -m 0755 $(@D)/examples/test-uri $(TARGET_DIR)/usr/bin
        $(INSTALL) -m 0755 $(@D)/examples/test-video $(TARGET_DIR)/usr/bin
        $(INSTALL) -m 0755 $(@D)/gst/rtsp-server/.libs/*.so* $(TARGET_DIR)/usr/lib
endef

define GST_RTSP_SERVER_UNINSTALL_TARGET_CMDS
        rm -f $(TARGET_DIR)/usr/bin/test-launch
        rm -f $(TARGET_DIR)/usr/bin/test-auth
        rm -f $(TARGET_DIR)/usr/bin/test-mp4
        rm -f $(TARGET_DIR)/usr/bin/test-ogg
        rm -f $(TARGET_DIR)/usr/bin/test-sdp
        rm -f $(TARGET_DIR)/usr/bin/test-uri
        rm -f $(TARGET_DIR)/usr/bin/test-video
endef


$(eval $(autotools-package))

#############################################################
#
# v4l2grab
#
#############################################################

V4L2GRAB_VERSION = HEAD
V4L2GRAB_SITE = http://github.com/twam/v4l2grab/tarball/$(V4L2GRAB_VERSION)
V4L2GRAB_INSTALL_TARGET = YES
V4L2GRAB_AUTORECONF = YES
V4L2GRAB_DEPENDENCIES = libv4l

define V4L2GRAB_INSTALL_TARGET_CMDS

	mkdir -p $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/v4l2grab $(TARGET_DIR)/usr/bin
endef

define V4L2GRAB_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/bin/v4l2grab
endef

$(eval $(autotools-package))

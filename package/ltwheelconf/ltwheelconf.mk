################################################################################
#
# ltwheelconf
#
################################################################################

LTWHEELCONF_VERSION = HEAD
LTWHEELCONF_SITE = http://github.com/TripleSpeeder/LTWheelConf/tarball/$(LTWHEELCONF_VERSION)
LTWHEELCONF_DEPENDENCIES = libusb
LTWHEELCONF_INSTALL_STAGING = YES
LTWHEELCONF_INSTALL_TARGET = YES

LTWHEELCONF_PLATFORM = dm365

define LTWHEELCONF_BUILD_CMDS

        $(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef


define LTWHEELCONF_INSTALL_TARGET_CMDS
        $(INSTALL) -m 0744 -D $(@D)/ltwheelconf \
                $(TARGET_DIR)/usr/bin/ltwheelconf
        chmod +x $(TARGET_DIR)/usr/bin/ltwheelconf
endef

define LTWHEELCONF_UNINSTALL_TARGET_CMDS
        $(RM) $(addprefix $(TARGET_DIR)/usr/bin, ltwheelconf)
endef


$(eval $(generic-package))

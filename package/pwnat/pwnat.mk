################################################################################
#
# pwnat
#
################################################################################

PWNAT_VERSION = master
PWNAT_SITE = http://github.com/samyk/pwnat/tarball/$(PWNAT_VERSION)
PWNAT_INSTALL_STAGING = YES

define PWNAT_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define PWNAT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/pwnat $(TARGET_DIR)/usr/sbin/pwnat
endef

$(eval $(generic-package))

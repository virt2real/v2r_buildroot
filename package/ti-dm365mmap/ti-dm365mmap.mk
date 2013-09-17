#############################################################
#
# ti-dm365mmap
#
#############################################################

TI_DM365MMAP_VERSION = xxx
TI_DM365MMAP_SITE = indvsdk
TI_DM365MMAP_DEPENDENCIES = linux
TI_DM365MMAP_INSTALL_STAGING = YES

define TI_DM365MMAP_BUILD_CMDS
	$(MAKE1) LINUXKERNEL_INSTALL_DIR=$(LINUX_DIR) \
		MVTOOL_PREFIX=$(TARGET_CROSS) \
		UCTOOL_PREFIX=$(TARGET_CROSS) \
		-C $(@D)/module

	# TODO: Build userland library
endef

define TI_DM365MMAP_INSTALL_STAGING_CMDS
	# TODO: Install userland library and header
endef

define TI_DM365MMAP_INSTALL_TARGET_CMDS
	$(MAKE) -C $(LINUX_DIR) M=$(@D)/module \
                INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
endef

$(eval $(generic-package))

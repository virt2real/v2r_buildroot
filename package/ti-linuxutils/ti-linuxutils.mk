#############################################################
#
# ti-linuxutils
#
#############################################################

TI_LINUXUTILS_VERSION = 2_26_01_02
TI_LINUXUTILS_SOURCE = linuxutils_$(TI_LINUXUTILS_VERSION).tar.gz
TI_LINUXUTILS_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/linuxutils/$(TI_LINUXUTILS_VERSION)/exports/
TI_LINUXUTILS_INSTALL_STAGING = YES
TI_LINUXUTILS_DEPENDENCIES = linux

TI_LINUXUTILS_INSTALL_DIR_RECIPE = /usr/share/ti/ti-linuxutils-tree
TI_LINUXUTILS_INSTALL_DIR = $(STAGING_DIR)$(TI_LINUXUTILS_INSTALL_DIR_RECIPE)

define TI_LINUXUTILS_BUILD_CMDS
	# For the DM365, we need cmem, edma, and irq
	$(MAKE1) LINUXKERNEL_INSTALL_DIR=$(LINUX_DIR) \
		MVTOOL_PREFIX=$(TARGET_CROSS) \
		UCTOOL_PREFIX=$(TARGET_CROSS) \
		-C $(@D)/packages/ti/sdo/linuxutils/cmem clean debug release

	$(MAKE1) LINUXKERNEL_INSTALL_DIR=$(LINUX_DIR) \
		MVTOOL_PREFIX=$(TARGET_CROSS) \
		UCTOOL_PREFIX=$(TARGET_CROSS) \
		-C $(@D)/packages/ti/sdo/linuxutils/edma clean debug release

	$(MAKE1) LINUXKERNEL_INSTALL_DIR=$(LINUX_DIR) \
		MVTOOL_PREFIX=$(TARGET_CROSS) \
		UCTOOL_PREFIX=$(TARGET_CROSS) \
		-C $(@D)/packages/ti/sdo/linuxutils/irq clean debug release
endef

define TI_LINUXUTILS_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_LINUXUTILS_INSTALL_DIR)
	cp -pPrf $(@D)/* $(TI_LINUXUTILS_INSTALL_DIR)
endef

define TI_LINUXUTILS_INSTALL_TARGET_CMDS
	# Install CMEM
	$(MAKE) -C $(LINUX_DIR) M=$(@D)/packages/ti/sdo/linuxutils/cmem/src/module \
                INSTALL_MOD_PATH=$(TARGET_DIR) modules_install

	# Install edmak
	$(MAKE) -C $(LINUX_DIR) M=$(@D)/packages/ti/sdo/linuxutils/edma/src/module \
                INSTALL_MOD_PATH=$(TARGET_DIR) modules_install

	# Install irqk
	$(MAKE) -C $(LINUX_DIR) M=$(@D)/packages/ti/sdo/linuxutils/irq/src/module \
                INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
endef

$(eval $(generic-package))

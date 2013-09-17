#############################################################
#
# ti-xdctools
#
#############################################################

TI_XDCTOOLS_VERSION = 3_16_03_36
TI_XDCTOOLS_SOURCE = xdctools_setuplinux_$(TI_XDCTOOLS_VERSION).bin
TI_XDCTOOLS_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/rtsc/$(TI_XDCTOOLS_VERSION)/exports/
TI_XDCTOOLS_INSTALL_STAGING = YES
TI_XDCTOOLS_INSTALL_TARGET = NO

TI_XDCTOOLS_INSTALL_DIR_RECIPE = /usr/share/ti/ti-xdctools-tree
TI_XDCTOOLS_INSTALL_DIR = $(STAGING_DIR)$(TI_XDCTOOLS_INSTALL_DIR_RECIPE)

define TI_XDCTOOLS_EXTRACT_CMDS
	chmod +x $(DL_DIR)/$(TI_XDCTOOLS_SOURCE)
	HOME=$(BUILD_DIR) $(DL_DIR)/$(TI_XDCTOOLS_SOURCE) --mode silent
        mv $(BUILD_DIR)/xdctools_$(TI_XDCTOOLS_VERSION)/* $(@D)
        rmdir $(BUILD_DIR)/xdctools_$(TI_XDCTOOLS_VERSION)/
endef

define TI_XDCTOOLS_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_XDCTOOLS_INSTALL_DIR)
	cp -pPrf $(@D)/* $(TI_XDCTOOLS_INSTALL_DIR)
endef

$(eval $(generic-package))

#############################################################
#
# ti-framework-components
#
#############################################################

TI_FRAMEWORK_COMPONENTS_VERSION = 2_26_00_01
TI_FRAMEWORK_COMPONENTS_SOURCE = framework_components_$(TI_FRAMEWORK_COMPONENTS_VERSION),lite.tar.gz
TI_FRAMEWORK_COMPONENTS_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/fc/$(TI_FRAMEWORK_COMPONENTS_VERSION)/exports/
TI_FRAMEWORK_COMPONENTS_INSTALL_STAGING = YES
TI_FRAMEWORK_COMPONENTS_INSTALL_TARGET = NO

TI_FRAMEWORK_COMPONENTS_INSTALL_DIR_RECIPE = /usr/share/ti/ti-framework-components-tree
TI_FRAMEWORK_COMPONENTS_INSTALL_DIR = $(STAGING_DIR)$(TI_FRAMEWORK_COMPONENTS_INSTALL_DIR_RECIPE)

define TI_FRAMEWORK_COMPONENTS_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_FRAMEWORK_COMPONENTS_INSTALL_DIR)
	cp -pPrf $(@D)/* $(TI_FRAMEWORK_COMPONENTS_INSTALL_DIR)
endef

$(eval $(generic-package))

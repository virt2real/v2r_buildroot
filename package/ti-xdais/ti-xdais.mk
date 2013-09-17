#############################################################
#
# ti-xdais
#
#############################################################

TI_XDAIS_VERSION = 6_26_01_03
TI_XDAIS_SOURCE = xdais_$(TI_XDAIS_VERSION).tar.gz
TI_XDAIS_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/xdais/$(TI_XDAIS_VERSION)/exports/
TI_XDAIS_INSTALL_STAGING = YES
TI_XDAIS_INSTALL_TARGET = NO

TI_XDAIS_INSTALL_DIR_RECIPE = /usr/share/ti/ti-xdais-tree
TI_XDAIS_INSTALL_DIR = $(STAGING_DIR)$(TI_XDAIS_INSTALL_DIR_RECIPE)

define TI_XDAIS_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)$(TI_XDAIS_INSTALL_DIR_RECIPE)
	cp -pPrf $(@D)/* $(STAGING_DIR)$(TI_XDAIS_INSTALL_DIR_RECIPE)
endef

$(eval $(generic-package))

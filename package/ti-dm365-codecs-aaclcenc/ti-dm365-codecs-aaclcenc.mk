#############################################################
#
# ti-dm365-codecs-aaclcenc
#
#############################################################

TI_DM365_CODECS_AACLCENC_VERSION = 3_5_00
TI_DM365_CODECS_AACLCENC_BASE = dm365_aaclcenc_$(TI_DM365_CODECS_AACLCENC_VERSION)_production
TI_DM365_CODECS_AACLCENC_SOURCE = $(TI_DM365_CODECS_AACLCENC_BASE).bin
TI_DM365_CODECS_AACLCENC_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/codecs/DM365/DM365_latest

TI_DM365_CODECS_AACLCENC_INSTALL_STAGING = YES
TI_DM365_CODECS_AACLCENC_INSTALL_TARGET = NO

TI_CODECS_INSTALL_DIR_RECIPE = /usr/share/ti/ti-codecs
TI_CODECS_INSTALL_DIR = $(STAGING_DIR)$(TI_CODECS_INSTALL_DIR_RECIPE)

define TI_DM365_CODECS_AACLCENC_EXTRACT_CMDS
	chmod +x $(DL_DIR)/$(TI_DM365_CODECS_AACLCENC_SOURCE)
	HOME=$(BUILD_DIR) $(DL_DIR)/$(TI_DM365_CODECS_AACLCENC_SOURCE) --mode silent
	rm -fr $(@D)
        mv $(BUILD_DIR)/$(TI_DM365_CODECS_AACLCENC_BASE)/aaclc_enc_$(TI_DM365_CODECS_AACLCENC_VERSION)_production_dm365_mvl/packages-production $(@D)
        rm -fr $(BUILD_DIR)/$(TI_DM365_CODECS_AACLCENC_BASE)/
endef

define TI_DM365_CODECS_AACLCENC_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_CODECS_INSTALL_DIR)/packages
	cp -pPrf $(@D)/* $(TI_CODECS_INSTALL_DIR)/packages
endef

$(eval $(generic-package))

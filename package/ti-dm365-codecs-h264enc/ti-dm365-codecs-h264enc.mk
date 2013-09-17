#############################################################
#
# ti-dm365-codecs-h264enc
#
#############################################################

TI_DM365_CODECS_H264ENC_VERSION = 02_30_00_04
TI_DM365_CODECS_H264ENC_SOURCE = dm365_h264enc_$(TI_DM365_CODECS_H264ENC_VERSION)_production.bin
TI_DM365_CODECS_H264ENC_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/codecs/DM365/DM365_latest

TI_DM365_CODECS_H264ENC_INSTALL_STAGING = YES
TI_DM365_CODECS_H264ENC_INSTALL_TARGET = NO

TI_CODECS_INSTALL_DIR_RECIPE = /usr/share/ti/ti-codecs
TI_CODECS_INSTALL_DIR = $(STAGING_DIR)$(TI_CODECS_INSTALL_DIR_RECIPE)

define TI_DM365_CODECS_H264ENC_EXTRACT_CMDS
	chmod +x $(DL_DIR)/$(TI_DM365_CODECS_H264ENC_SOURCE)
	HOME=$(BUILD_DIR) $(DL_DIR)/$(TI_DM365_CODECS_H264ENC_SOURCE) --mode silent
	cd $(BUILD_DIR)/dm365_h264enc_$(TI_DM365_CODECS_H264ENC_VERSION)_production && tar xf dm365_h264enc_$(TI_DM365_CODECS_H264ENC_VERSION)_production.tar
        mv $(BUILD_DIR)/dm365_h264enc_$(TI_DM365_CODECS_H264ENC_VERSION)_production/dm365_h264enc_$(TI_DM365_CODECS_H264ENC_VERSION)_production/* $(@D)
        rm -fr $(BUILD_DIR)/dm365_h264enc_$(TI_DM365_CODECS_H264ENC_VERSION)_production/
endef

define TI_DM365_CODECS_H264ENC_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_CODECS_INSTALL_DIR)
	cp -pPrf $(@D)/* $(TI_CODECS_INSTALL_DIR)
endef

$(eval $(generic-package))

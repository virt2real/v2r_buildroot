#############################################################
#
# ti-dmai
#
#############################################################

TI_DMAI_VERSION = 645
TI_DMAI_SITE_METHOD = svn
TI_DMAI_SITE = https://gforge.ti.com/svn/dmai/trunk --username anonymous --password ''
TI_DMAI_INSTALL_STAGING = YES
TI_DMAI_DEPENDENCIES = alsa-lib ti-framework-components ti-codec-engine ti-xdctools ti-dm365-h264enc

TI_DMAI_INSTALL_DIR_RECIPE = /usr/share/ti/ti-dmai-tree
TI_DMAI_INSTALL_DIR = $(STAGING_DIR)$(TI_DMAI_INSTALL_DIR_RECIPE)

TI_DMAI_PLATFORM = dm368_al

define TI_DMAI_BUILD_CMDS
	#$(MAKE) XDC_INSTALL_DIR="$(TI_XDCTOOLS_INSTALL_DIR)" \
	#	PLATFORM="$(TI_DMAI_PLATFORM)" \
	#	-C $(@D)/davinci_multimedia_application_interface \
	#	clean

	$(MAKE1) PLATFORM="$(TI_DMAI_PLATFORM)" \
		CE_INSTALL_DIR="$(TI_CODEC_ENGINE_INSTALL_DIR)" \
		CODEC_INSTALL_DIR="$(TI_CODECS_INSTALL_DIR)" \
		FC_INSTALL_DIR="$(TI_FRAMEWORK_COMPONENTS_INSTALL_DIR)" \
		LINUXKERNEL_INSTALL_DIR="$(LINUX_DIR)" \
		XDC_INSTALL_DIR="$(TI_XDCTOOLS_INSTALL_DIR)" \
		BIOS_INSTALL_DIR="$(TI_BIOS_INSTALL_DIR)" \
		LINUXLIBS_INSTALL_DIR="$(STAGING_DIR)/usr" \
		USER_XDC_PATH="$(TI_CODEC_ENGINE_INSTALL_DIR)/examples" \
		CROSS_COMPILE=$(TARGET_CROSS) \
		CSTOOL_DIR="$(HOST_DIR)/usr" \
		VERBOSE="true" \
		XDAIS_INSTALL_DIR="$(TI_XDAIS_INSTALL_DIR)" \
		LINK_INSTALL_DIR="" \
		CMEM_INSTALL_DIR="$(TI_LINUXUTILS_INSTALL_DIR)" \
		LPM_INSTALL_DIR="$(TI_LPM_INSTALL_DIR)" \
		EDMA3_LLD_INSTALL_DIR="$(TI_EDMA3_LLD_INSTALL_DIR)" \
		MVTOOL_PREFIX=$(TARGET_CROSS) \
		-C $(@D)/davinci_multimedia_application_interface/dmai
endef

define TI_DMAI_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_DMAI_INSTALL_DIR)
	cp -pPrf $(@D)/davinci_multimedia_application_interface/dmai/* $(TI_DMAI_INSTALL_DIR)
endef

define TI_DMAI_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/share/ti/ti-dmai-apps
	$(MAKE1) PLATFORM="$(TI_DMAI_PLATFORM)" \
		CE_INSTALL_DIR="$(TI_CODEC_ENGINE_INSTALL_DIR)" \
		CODEC_INSTALL_DIR="$(TI_CODECS_INSTALL_DIR)" \
		FC_INSTALL_DIR="$(TI_FRAMEWORK_COMPONENTS_INSTALL_DIR)" \
		LINUXKERNEL_INSTALL_DIR="$(LINUX_DIR)" \
		XDC_INSTALL_DIR="$(TI_XDCTOOLS_INSTALL_DIR)" \
		BIOS_INSTALL_DIR="$(TI_BIOS_INSTALL_DIR)" \
		LINUXLIBS_INSTALL_DIR="$(STAGING_DIR)/usr" \
		USER_XDC_PATH="$(TI_CODEC_ENGINE_INSTALL_DIR)/examples" \
		CROSS_COMPILE=$(TARGET_CROSS) \
		CSTOOL_DIR="" \
		VERBOSE="true" \
		XDAIS_INSTALL_DIR="$(TI_XDAIS_INSTALL_DIR)" \
		LINK_INSTALL_DIR="" \
		CMEM_INSTALL_DIR="$(TI_LINUXUTILS_INSTALL_DIR)" \
		LPM_INSTALL_DIR="$(TI_LPM_INSTALL_DIR)" \
		EDMA3_LLD_INSTALL_DIR="$(TI_EDMA3_LLD_INSTALL_DIR)" \
		MVTOOL_PREFIX=$(TARGET_CROSS) \
		EXEC_DIR=$(TARGET_DIR)/usr/share/ti/ti-dmai-apps \
		-C $(@D)/davinci_multimedia_application_interface/dmai \
		install
endef

$(eval $(generic-package))

#############################################################
#
# ti-codec-engine
#
#############################################################

TI_CODEC_ENGINE_VERSION = 2_26_02_11
TI_CODEC_ENGINE_SOURCE = codec_engine_$(TI_CODEC_ENGINE_VERSION),lite.tar.gz
TI_CODEC_ENGINE_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/ce/$(TI_CODEC_ENGINE_VERSION)/exports/
TI_CODEC_ENGINE_INSTALL_STAGING = YES

TI_CODEC_ENGINE_DEPENDENCIES = ti-framework-components ti-xdais ti-xdctools

TI_CODEC_ENGINE_INSTALL_DIR_RECIPE = /usr/share/ti/ti-codec-engine-tree
TI_CODEC_ENGINE_INSTALL_DIR = $(STAGING_DIR)$(TI_CODEC_ENGINE_INSTALL_DIR_RECIPE)

define TI_CODEC_ENGINE_CONFIGURE_CMDS
	# Terrible hack to make ar work. I tried to update the package.mak files
	# to make it right, but they get regenerated.
	mkdir -p $(HOST_DIR)/usr/arm-none-linux-gnueabi/bin
	ln -fs $(TARGET_CROSS)ar $(HOST_DIR)/usr/arm-none-linux-gnueabi/bin/ar
endef

define TI_CODEC_ENGINE_BUILD_CMDS_DONT_BUILD
	for i in codecs extensions servers apps ; do \
                cd $(@D)/examples/ti/sdo/ce/examples/$$i; \
                make DEVICES="DM365" \
                     GPPOS="LINUX_GCC" \
                     PROGRAMS="APP_LOCAL" \
                     CE_INSTALL_DIR="$(@D)" \
                     XDC_INSTALL_DIR="$(TI_XDCTOOLS_INSTALL_DIR)" \
                     BIOS_INSTALL_DIR="$(TI_BIOS_INSTALL_DIR)" \
                     BIOSUTILS_INSTALL_DIR="$(TI_BIOSUTILS_INSTALL_DIR)" \
		     DSPLINK_INSTALL_DIR="$(TI_DSPLINK_INSTALL_DIR)" \
                     XDAIS_INSTALL_DIR="$(TI_XDAIS_INSTALL_DIR)" \
                     FC_INSTALL_DIR="$(TI_FRAMEWORK_COMPONENTS_INSTALL_DIR)" \
                     CMEM_INSTALL_DIR="$(TI_LINUXUTILS_INSTALL_DIR)" \
                     LPM_INSTALL_DIR="$(TI_LPM_INSTALL_DIR)" \
                     EDMA3_LLD_INSTALL_DIR="$(TI_EDMA3_LLD_INSTALL_DIR)" \
                     CGTOOLS_V5T="$(HOST_DIR)/usr" \
                     CGTOOLS_C64P="" \
                     CGTOOLS_C674="" \
                     all; \
        done
endef

define TI_CODEC_ENGINE_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_CODEC_ENGINE_INSTALL_DIR)
	cp -pPrf $(@D)/* $(TI_CODEC_ENGINE_INSTALL_DIR)
endef

define TI_CODEC_ENGINE_INSTALL_TARGET_CMDS
	# Not sure what to install...
endef

$(eval $(generic-package))

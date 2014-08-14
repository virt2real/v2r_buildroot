################################################################################
#
# gst-ti-dmai
#
################################################################################

GST_TI_DMAI_VERSION = master
GST_TI_DMAI_SITE = http://github.com/virt2real/gst-ti-dmai/tarball/$(GST_TI_DMAI_VERSION)
GST_TI_DMAI_INSTALL_STAGING = YES
GST_TI_DMAI_DEPENDENCIES = gstreamer host-pkgconf
GST_TI_DMAI_AUTORECONF = YES

GST_TI_DMAI_CONF_OPT = \
	--with-preset=dm365  \
	--with-platform=dm365 \
	--target=arm-none-linux-gnueabi \
	--host=arm-none-linux-gnueabi \
	--with-sysroot=$(STAGING_DIR)

GST_TI_DMAI_PLATFORM = dm365

GST_TI_DMAI_CONF_ENV = \
		PLATFORM="$(GST_TI_DMAI_PLATFORM)" \
		GST_TI_PLATFORM="$(GST_TI_DMAI_PLATFORM)" \
		PLATFORM_XDC="$(GST_TI_DMAI_DEVICE)" \
		XDAIS_INSTALL_DIR="$(DEVDIR)/dvsdk/xdais_6_26_01_03" \
		CE_INSTALL_DIR="$(DEVDIR)/dvsdk/codec-engine_2_26_02_11" \
		CODEC_INSTALL_DIR="$(DEVDIR)/dvsdk/codecs-dm365_4_02_00_00" \
		FC_INSTALL_DIR="$(DEVDIR)/dvsdk/framework-components_2_26_00_01" \
		LINUXKERNEL_INSTALL_DIR="$(DEVDIR)/kernel" \
		LINUXLIBS_INSTALL_DIR="$(STAGING_DIR)/usr" \
		XDC_PATH="$(DEVDIR)/dvsdk/xdctools_3_16_03_36" \
		XDC_INSTALL_DIR="$(DEVDIR)/dvsdk/xdctools_3_16_03_36" \
		XDC_USER_PATH="$(DEVDIR)/dvsdk/xdctools_3_16_03_36/examples" \
		CROSS_COMPILE=$(TARGET_CROSS) \
		CSTOOL_DIR="$(HOST_DIR)/usr" \
		MVTOOL_DIR="$(HOST_DIR)/usr" \
		CMEM_INSTALL_DIR="$(DEVDIR)/dvsdk/linuxutils_2_26_03_06" \
		DMAI_INSTALL_DIR="$(DEVDIR)/dvsdk/dmai_2_20_00_15"

GST_TI_DMAI_MAKE_ENV = $(GST_TI_DMAI_CONF_ENV)

$(eval $(autotools-package))

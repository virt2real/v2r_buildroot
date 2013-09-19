################################################################################
#
# ti-dmai
#
################################################################################

TI_DMAI_VERSION = HEAD
TI_DMAI_SITE = http://github.com/virt2real/dmai/tarball/$(TI_DMAI_VERSION)

TI_DMAI_CONF_OPT = \
	--with-preset=dm365  \
	--with-platform=dm365 \
	--target=arm-none-linux-gnueabi \
	--host=arm-none-linux-gnueabi
TI_DMAI_INSTALL_STAGING = YES

TI_DMAI_DEPENDENCIES = gstreamer host-pkgconf

$(eval $(autotools-package))

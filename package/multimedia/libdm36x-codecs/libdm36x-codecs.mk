################################################################################
#
# gst1-ce-plugin
#
################################################################################

LIBDM36X_CODECS_VERSION = HEAD
LIBDM36X_CODECS_SITE = http://github.com/RidgeRun/libdm36x-codecs/tarball/$(LIBDM36X_CODECS_VERSION)

define LIBDM36X_CODECS_PPH
    
endef

LIBDM36X_CODECS_POST_PATCH_HOOKS += LIBDM36X_CODECS_PPH

LIBDM36X_CODECS_CONF_OPT = \
	--with-dvsdkdir=${DEVDIR}/dvsdk \
	--target=arm-none-linux-gnueabi \
	--host=arm-none-linux-gnueabi

$(eval $(autotools-package))

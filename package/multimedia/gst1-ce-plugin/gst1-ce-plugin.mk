################################################################################
#
# gst1-ce-plugin
#
################################################################################

GST1_CE_PLUGIN_VERSION = HEAD
GST1_CE_PLUGIN_SITE = http://github.com/RidgeRun/gst-ce-plugin/tarball/$(GST1_CE_PLUGIN_VERSION)

define GST1_CE_PLUGIN_PPH
	chmod 1777 $(@D)/configure
endef

GST1_CE_PLUGIN_POST_PATCH_HOOKS += GST1_CE_PLUGIN_PPH

GST1_CE_PLUGIN_CONF_OPT = \
	--disable-examples \
	--disable-debug \
	--disable-valgrind


GST1_CE_PLUGIN_DEPENDENCIES = gstreamer1 gst1-plugins-base

$(eval $(autotools-package))

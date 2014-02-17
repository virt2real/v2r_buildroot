#############################################################
#
# powertop
#
#############################################################

POWERTOP_VERSION = HEAD
POWERTOP_SITE = http://github.com/vickylinuxer/powertop/tarball/$(POWERTOP_VERSION)
POWERTOP_CONF_OPT += 

$(eval $(autotools-package))

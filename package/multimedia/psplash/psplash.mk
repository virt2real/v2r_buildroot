################################################################################
#
# psplash
#
################################################################################

PSPLASH_VERSION = afd4e228c606a9998feae44a3fed4474803240b7
PSPLASH_SITE = git://git.yoctoproject.org/psplash
PSPLASH_LICENSE = GPLv2+
PSPLASH_AUTORECONF = YES


define PSPLASH_BUILD_CMDS
	apt-get install libgtk2.0-dev -y
        cp package/multimedia/psplash/screenlogo.png $(@D)/base-images/screenlogo.png
	cd $(@D) && $(@D)/make-image-header.sh $(@D)/base-images/screenlogo.png POKY && mv screenlogo-img.h psplash-poky-img.h
endef


$(eval $(autotools-package))

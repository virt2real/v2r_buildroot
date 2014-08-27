#############################################################
#
# nanomsg
#
#############################################################

NANOMSG_VERSION = master
NANOMSG_SITE = http://github.com/nanomsg/nanomsg/tarball/$(NANOMSG_VERSION)
NANOMSG_INSTALL_STAGING = YES
NANOMSG_AUTORECONF = YES

$(eval $(autotools-package))

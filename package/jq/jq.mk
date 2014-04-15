#############################################################
#
# jq
#
#############################################################

JQ_VERSION = master
JQ_SITE = git://github.com/stedolan/jq.git

# Autoreconf required as we use the git tree
JQ_AUTORECONF = YES
JQ_INSTALL_STAGING = YES

$(eval $(autotools-package))

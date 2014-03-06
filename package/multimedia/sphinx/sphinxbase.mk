SPHINXBASE_VERSION=0.6.1
SPHINXBASE_SOURCE=sphinxbase-$(SPHINXBASE_VERSION).tar.gz
SPHINXBASE_SITE=http://downloads.sourceforge.net/project/cmusphinx/sphinxbase/$(SPHINXBASE_VERSION)
SPHINXBASE_AUTORECONF = YES
SPHINXBASE_INSTALL_STAGING = YES
SPHINXBASE_INSTALL_TARGET = YES
SPHINXBASE_DEPENDENCIES =

$(eval $(autotools-package))
#$(eval $(call AUTOTARGETS,package/multimedia,sphinxbase))

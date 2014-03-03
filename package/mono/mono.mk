################################################################################
#
# mono
#
################################################################################

MONO_VERSION        = 3.2.5
MONO_SOURCE	     = mono-$(MONO_VERSION).tar.bz2
MONO_SITE            = http://download.mono-project.com/sources/mono/
MONO_LICENSE         = GPLv2 LGPLv2.1+
MONO_LICENSE_FILES   = COPYING LGPL-2.1
MONO_DEPENDENCIES    = libglib2 pkg-config

MONO_CONF_OPT += --with-tls=pthread --with-sigaltstack=no --disable-mono-debugger --disable-backtrace

$(eval $(autotools-package))

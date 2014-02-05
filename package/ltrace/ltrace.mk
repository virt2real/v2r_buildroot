#############################################################
#
# ltrace
#
#############################################################

LTRACE_VERSION = 0.7.2
LTRACE_SITE = https://alioth.debian.org/plugins/scmgit/cgi-bin/gitweb.cgi?p=ltrace/ltrace.git;a=snapshot;h=d66c8b11facf570d96a49c1b812b90101c62023b;sf=tgz
LTRACE_SOURCE = ltrace-$(LTRACE_VERSION).tar.bz2
LTRACE_DEPENDENCIES = libelf
LTRACE_AUTORECONF = YES
LTRACE_CONF_OPT = --disable-werror
LTRACE_LICENSE = GPLv2
LTRACE_LICENSE_FILES = COPYING

$(eval $(autotools-package))

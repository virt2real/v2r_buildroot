################################################################################
#
# linuxconsoletools
#
################################################################################

LINUXCONSOLETOOLS_VERSION = 1.4.7
LINUXCONSOLETOOLS_SOURCE = linuxconsoletools-$(LINUXCONSOLETOOLS_VERSION).tar.bz2
LINUXCONSOLETOOLS_SITE = http://citylan.dl.sourceforge.net/project/linuxconsole/
LINUXCONSOLETOOLS_INSTALL_STAGING = YES
LINUXCONSOLETOOLS_INSTALL_TARGET = YES

LINUXCONSOLETOOLS_PLATFORM = dm365

define LINUXCONSOLETOOLS_BUILD_CMDS

        $(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef


define LINUXCONSOLETOOLS_INSTALL_TARGET_CMDS
        $(INSTALL) -m 0744 -D $(@D)/utils/ffcfstress $(TARGET_DIR)/usr/bin/ffcfstress
        $(INSTALL) -m 0744 -D $(@D)/utils/ffset $(TARGET_DIR)/usr/bin/ffset
        $(INSTALL) -m 0744 -D $(@D)/utils/fftest $(TARGET_DIR)/usr/bin/fftest
        $(INSTALL) -m 0744 -D $(@D)/utils/inputattach $(TARGET_DIR)/usr/bin/inputattach
        $(INSTALL) -m 0744 -D $(@D)/utils/jscal $(TARGET_DIR)/usr/bin/jscal
        $(INSTALL) -m 0744 -D $(@D)/utils/jstest $(TARGET_DIR)/usr/bin/jstest

        #chmod +x $(TARGET_DIR)/usr/bin/ltwheelconf
endef

define LINUXCONSOLETOOLS_UNINSTALL_TARGET_CMDS
        $(RM) $(addprefix $(TARGET_DIR)/usr/bin, ffcfstress ffset fftest inputattach jscal jstest)
endef


$(eval $(generic-package))


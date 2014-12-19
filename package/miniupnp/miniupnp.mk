#############################################################
#
# miniupnp
#
#############################################################

MINIUPNP_VERSION = HEAD
MINIUPNP_SITE = http://github.com/miniupnp/miniupnp/tarball/$(MINIUPNP_VERSION)

define MINIUPNP_BUILD_CMDS
	$(MAKE) -C $(@D)/minissdpd CC="$(TARGET_CC) $(TARGET_CFLAGS)"
	$(MAKE) -C $(@D)/miniupnpc CC="$(TARGET_CC) $(TARGET_CFLAGS)"

	cp package/miniupnp/config.h $(@D)/miniupnpd/config.h
	IPTABLESPATH=$(DEVDIR)/fs/output/build/iptables-1.4.18 $(MAKE) -f $(@D)/miniupnpd/Makefile.linux -C $(@D)/miniupnpd CC="$(TARGET_CC) $(TARGET_CFLAGS)"
endef

define MINIUPNP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
	mkdir -p $(TARGET_DIR)/etc/init.d.sample

	$(INSTALL) -m 0755 -D $(@D)/miniupnpc/upnpc-static $(TARGET_DIR)/usr/bin/upnpc

	$(INSTALL) -D -m 0755 $(@D)/minissdpd/minissdpd $(TARGET_DIR)/usr/bin/minissdpd
	$(INSTALL) -m 755 -D package/miniupnp/S55ssdpd $(TARGET_DIR)/etc/init.d.sample/S55ssdpd
	$(INSTALL) -m 755 -D package/miniupnp/S80upnpd $(TARGET_DIR)/etc/init.d.sample/S80upnpd

	$(INSTALL) -m 0755 -D $(@D)/miniupnpd/miniupnpd $(TARGET_DIR)/usr/bin/miniupnpd
	$(INSTALL) -m 0644 -D package/miniupnp/miniupnpd.conf $(TARGET_DIR)/etc/miniupnpd.conf
	$(INSTALL) -m 0755 -D package/miniupnp/upnpd_prepare.sh $(TARGET_DIR)/etc/virt2real/upnpd_prepare.sh
	$(INSTALL) -m 0755 -D package/busybox/udhcpc.script $(TARGET_DIR)/usr/share/udhcpc/default.script

endef

define MINIUPNP_CLEAN_CMDS
	rm -f $(TARGET_DIR)/usr/bin/upnpc
	rm -f $(TARGET_DIR)/usr/bin/minissdpd
	rm -f $(TARGET_DIR)/etc/init.d.sample/S55ssdpd
	rm -f $(TARGET_DIR)/etc/init.d.sample/S80upnpd
	rm -f $(TARGET_DIR)/usr/bin/miniupnpd
	rm -f $(TARGET_DIR)/etc/miniupnpd.conf
	rm -f $(TARGET_DIR)/etc/virt2real/upnpd_prepare.sh
endef

$(eval $(generic-package))

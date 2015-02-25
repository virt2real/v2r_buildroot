################################################################################
#
# libnfc
#
################################################################################

LIBNFC_VERSION = 7b7f5061427b5456835dd48923a8cc0563cfd1e9
LIBNFC_SITE = http://libnfc.googlecode.com/git/
LIBNFC_SITE_METHOD = git
LIBNFC_LICENSE = LGPLv3+
LIBNFC_LICENSE_FILES = COPYING
LIBNFC_AUTORECONF = YES
LIBNFC_INSTALL_STAGING = YES

LIBNFC_DEPENDENCIES = host-pkgconf libusb libusb-compat

# N.B. The acr122 driver requires pcsc-lite.
#LIBNFC_CONF_OPT = --with-drivers=arygon,pn53x_usb
#LIBNFC_CONF_OPT = --with-drivers=arygon,pn532_uart --enable-serial-autoprobe
#LIBNFC_CONF_OPT = --with-drivers=arygon,pn532_uart --enable-debug
LIBNFC_CONF_OPT = --with-drivers=arygon,pn532_uart,pn532_spi,pn532_i2c


ifeq ($(BR2_PACKAGE_LIBNFC_EXAMPLES),y)
LIBNFC_CONF_OPT += --enable-example
LIBNFC_DEPENDENCIES += readline
else
LIBNFC_CONF_OPT += --disable-example
endif

define LIBNFC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/utils/nfc-list $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/utils/nfc-emulate-forum-tag4 $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/utils/nfc-mfclassic $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/utils/nfc-mfultralight $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/utils/nfc-read-forum-tag3 $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/utils/nfc-relay-picc $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/utils/nfc-scan-device $(TARGET_DIR)/usr/bin/

	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-anticol $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-dep-initiator $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-dep-target $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-emulate-forum-tag2 $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-emulate-tag $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-emulate-uid $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-mfsetuid $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-poll $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/nfc-relay $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/pn53x-diagnose $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/pn53x-sam $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/examples/pn53x-tamashell $(TARGET_DIR)/usr/bin/

	mkdir -p $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/libnfc/libnfc.la $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0644 $(@D)/libnfc/.libs/libnfc.a $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0755 $(@D)/libnfc/.libs/libnfc.so.5.0.0 $(TARGET_DIR)/usr/lib
	#mv $(@D)/libnfc/.libs/libnfc.so.5 $(TARGET_DIR)/usr/lib/
	#mv $(@D)/libnfc/.libs/libnfc.so $(TARGET_DIR)/usr/lib/

	mkdir -p $(TARGET_DIR)/usr/lib/pkgconfig
	$(INSTALL) -D -m 0644 $(@D)/libnfc.pc $(TARGET_DIR)/usr/lib/pkgconfig

	mkdir -p $(TARGET_DIR)/etc/nfc
	$(INSTALL) -m 0644 package/libnfc/libnfc.conf $(TARGET_DIR)/etc/nfc
	mkdir -p $(TARGET_DIR)/etc/nfc/devices.d
	$(INSTALL) -m 0644 package/libnfc/pn532_uart.conf $(TARGET_DIR)/etc/nfc/devices.d
endef

$(eval $(autotools-package))

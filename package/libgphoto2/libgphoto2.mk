#############################################################
#
# libgphoto2
#
#############################################################
LIBGPHOTO2_VERSION:=2.4.11
LIBGPHOTO2_PORT_VERSION:=0.8.0
LIBGPHOTO2_SOURCE:=libgphoto2-$(LIBGPHOTO2_VERSION).tar.bz2
LIBGPHOTO2_SITE:=http://sourceforge.net/projects/gphoto/files/
LIBGPHOTO2_CAT:=$(BZCAT)
LIBGPHOTO2_DIR:=$(BUILD_DIR)/libgphoto2-$(LIBGPHOTO2_VERSION)
LIBGPHOTO2_TARGET_BINARY:=usr/lib/libgphoto2.so

$(DL_DIR)/$(LIBGPHOTO2_SOURCE):
	 $(WGET) -P $(DL_DIR) $(LIBGPHOTO2_SITE)/$(LIBGPHOTO2_SOURCE)

$(LIBGPHOTO2_DIR)/.unpacked: $(DL_DIR)/$(LIBGPHOTO2_SOURCE)
	$(LIBGPHOTO2_CAT) $(DL_DIR)/$(LIBGPHOTO2_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	toolchain/patch-kernel.sh $(LIBGPHOTO2_DIR) package/libgphoto2/ libgphoto2-\*.patch
	touch $@

$(LIBGPHOTO2_DIR)/.configured: $(LIBGPHOTO2_DIR)/.unpacked
	(cd $(LIBGPHOTO2_DIR); rm -rf config.cache; \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		LTDLINCL=-I$(TARGET_DIR)/usr/include \
		LIBLTDL="-L$(TARGET_DIR)/usr/lib -lltdl" \
		LDFLAGS="$(LDFLAGS) -L$(TARGET_DIR)/usr/lib" \
		LIBS="$(LIBS) -lltdl" \
		./configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--with-drivers=ptp2 \
		--disable-ptpip \
		--disable-disk \
	)
	touch $@

$(LIBGPHOTO2_DIR)/.compiled: $(LIBGPHOTO2_DIR)/.configured
	$(MAKE) CC=$(TARGET_CC) -C $(LIBGPHOTO2_DIR)
	touch $@

$(STAGING_DIR)/$(LIBGPHOTO2_TARGET_BINARY): $(LIBGPHOTO2_DIR)/.compiled
	$(MAKE) prefix=$(STAGING_DIR)/usr -C $(LIBGPHOTO2_DIR) install

$(TARGET_DIR)/$(LIBGPHOTO2_TARGET_BINARY): $(STAGING_DIR)/$(LIBGPHOTO2_TARGET_BINARY)
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/libgphoto2/$(LIBGPHOTO2_VERSION)
	cp -dpf $(STAGING_DIR)/usr/lib/libgphoto2/$(LIBGPHOTO2_VERSION)/*.so $(TARGET_DIR)/usr/lib/libgphoto2/$(LIBGPHOTO2_VERSION)
	$(INSTALL) -d $(TARGET_DIR)/usr/lib/libgphoto2_port/$(LIBGPHOTO2_PORT_VERSION)
	cp -dpf $(STAGING_DIR)/usr/lib/libgphoto2_port/$(LIBGPHOTO2_PORT_VERSION)/*.so $(TARGET_DIR)/usr/lib/libgphoto2_port/$(LIBGPHOTO2_PORT_VERSION)
	$(INSTALL) -m 755 $(STAGING_DIR)/usr/lib/libgphoto2_port.so* $(TARGET_DIR)/usr/lib
	$(INSTALL) -m 755 $(STAGING_DIR)/$(LIBGPHOTO2_TARGET_BINARY)* $(TARGET_DIR)/usr/lib

libgphoto2: uclibc libtool libusb $(TARGET_DIR)/$(LIBGPHOTO2_TARGET_BINARY)

libgphoto2-source: $(DL_DIR)/$(LIBGPHOTO2_SOURCE)

libgphoto2-clean:
	$(RM) -rf $(TARGET_DIR)/usr/lib/libgphoto2_port
	$(RM) -rf $(TARGET_DIR)/usr/lib/libgphoto2
	$(RM) -rf $(TARGET_DIR)/usr/lib/libgphoto2_port.so*
	$(RM) -rf $(TARGET_DIR)/usr/lib/libgphoto2.so*
	$(MAKE) prefix=$(STAGING_DIR)/usr CC=$(TARGET_CC) -C $(LIBGPHOTO2_DIR) uninstall
	-$(MAKE) -C $(LIBGPHOTO2_DIR) clean

libgphoto2-dirclean:
	rm -rf $(LIBGPHOTO2_DIR)

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(strip $(BR2_PACKAGE_LIBGPHOTO2)),y)
TARGETS+=libgphoto2
endif

#############################################################
#
# gphotofs
#
#############################################################
GPHOTOFS_VERSION:=0.4.0
GPHOTOFS_SOURCE:=gphotofs-$(GPHOTOFS_VERSION).tar.bz2
#GPHOTOFS_SITE:=http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/gphoto/
GPHOTOFS_SITE:=http://sourceforge.net/projects/gphoto/files/
GPHOTOFS_CAT:=$(BZCAT)
GPHOTOFS_DIR:=$(BUILD_DIR)/gphotofs-$(GPHOTOFS_VERSION)
GPHOTOFS_TARGET_BINARY:=usr/bin/gphotofs

$(DL_DIR)/$(GPHOTOFS_SOURCE):
	 $(WGET) -P $(DL_DIR) $(GPHOTOFS_SITE)/$(GPHOTOFS_SOURCE)

$(GPHOTOFS_DIR)/.unpacked: $(DL_DIR)/$(GPHOTOFS_SOURCE)
	$(GPHOTOFS_CAT) $(DL_DIR)/$(GPHOTOFS_SOURCE) | tar -C $(BUILD_DIR) $(TAR_OPTIONS) -
	toolchain/patch-kernel.sh $(GPHOTOFS_DIR) package/gphotofs/ gphotofs-\*.patch
	touch $@

$(GPHOTOFS_DIR)/.configured: $(GPHOTOFS_DIR)/.unpacked
	(cd $(GPHOTOFS_DIR); rm -rf config.cache; \
		$(TARGET_CONFIGURE_OPTS) \
		$(TARGET_CONFIGURE_ARGS) \
		LTDLINCL=-I$(TARGET_DIR)/usr/include \
		LDFLAGS="$(LDFLAGS) -L$(TARGET_DIR)/usr/lib" \
		LIBS="$(LIBS) -lltdl" \
		./configure \
		--target=$(GNU_TARGET_NAME) \
		--host=$(GNU_TARGET_NAME) \
		--build=$(GNU_HOST_NAME) \
		--prefix=/usr \
		--bindir=$(STAGING_DIR)/usr/bin \
		--libdir=$(STAGING_DIR)/usr/lib \
		--includedir=$(STAGING_DIR)/usr/include \
	)
	touch $@

$(GPHOTOFS_DIR)/.compiled: $(GPHOTOFS_DIR)/.configured
	$(MAKE) CC=$(TARGET_CC) -C $(GPHOTOFS_DIR)

$(STAGING_DIR)/$(GPHOTOFS_TARGET_BINARY): $(GPHOTOFS_DIR)/.compiled
	$(MAKE) prefix=$(STAGING_DIR) -C $(GPHOTOFS_DIR) install

$(TARGET_DIR)/$(GPHOTOFS_TARGET_BINARY): $(STAGING_DIR)/$(GPHOTOFS_TARGET_BINARY)
	$(INSTALL) -m 755 $(STAGING_DIR)/$(GPHOTOFS_TARGET_BINARY)* $(TARGET_DIR)/$(GPHOTOFS_TARGET_BINARY)

gphotofs: uclibc libtool libgphoto2 libglib2 $(TARGET_DIR)/$(GPHOTOFS_TARGET_BINARY)

gphotofs-source: $(DL_DIR)/$(GPHOTOFS_SOURCE)

gphotofs-clean:
	$(RM) -rf $(TARGET_DIR)/$(GPHOTOFS_TARGET_BINARY)
	$(MAKE) DESTDIR=$(TARGET_DIR) CC=$(TARGET_CC) -C $(GPHOTOFS_DIR) uninstall
	-$(MAKE) -C $(GPHOTOFS_DIR) clean

gphotofs-dirclean:
	rm -rf $(GPHOTOFS_DIR)

#############################################################
#
# Toplevel Makefile options
#
#############################################################
ifeq ($(strip $(BR2_PACKAGE_GPHOTOFS)),y)
TARGETS+=gphotofs
endif

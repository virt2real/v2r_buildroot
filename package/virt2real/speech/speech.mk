SPEECH_VERSION = HEAD
SPEECH_SITE = http://github.com/virt2real/othersoft/tarball/$(SPEECH_VERSION)

define SPEECH_INSTALL_TARGET_CMDS

	mkdir -p $(TARGET_DIR)/etc/virt2real/speech
	cp -R $(@D)/speech/* $(TARGET_DIR)/etc/virt2real/speech/

endef

define SPEECH_UNINSTALL_TARGET_CMDS
	rm -Rf $(TARGET_DIR)/etc/virt2real/speech
endef

$(eval $(generic-package))

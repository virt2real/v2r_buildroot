###############################################################################
#
# espeak
#
###############################################################################

#ESPEAK_VERSION_MAJOR = 1.47
ESPEAK_VERSION_MAJOR = 1.48
#ESPEAK_VERSION = $(ESPEAK_VERSION_MAJOR).11
ESPEAK_VERSION = $(ESPEAK_VERSION_MAJOR).02
ESPEAK_SOURCE = espeak-$(ESPEAK_VERSION)-source.zip
ESPEAK_SITE = http://downloads.sourceforge.net/project/espeak/espeak/espeak-$(ESPEAK_VERSION_MAJOR)
ESPEAK_LICENSE = GPLv3+
ESPEAK_LICENSE_FILES = Licence.txt

ESPEAK_AUDIO_BACKEND = portaudio
ESPEAK_DEPENDENCIES = portaudio

ifeq ($(BR2_PACKAGE_ESPEAK_AUDIO_BACKEND_ALSA),y)
ESPEAK_AUDIO_BACKEND = portaudio
ESPEAK_DEPENDENCIES = portaudio
endif
ifeq ($(BR2_PACKAGE_ESPEAK_AUDIO_BACKEND_PULSEAUDIO),y)
ESPEAK_AUDIO_BACKEND = pulseaudio
ESPEAK_DEPENDENCIES = pulseaudio
endif

define ESPEAK_EXTRACT_CMDS
	unzip -d $(@D) $(DL_DIR)/$(ESPEAK_SOURCE)
	#mv $(@D)/espeak-$(ESPEAK_VERSION)-source/* $(@D)
	mv $(@D)/espeak-$(ESPEAK_VERSION_MAJOR).01-source/* $(@D)
	$(RM) -r $(@D)/espeak-$(ESPEAK_VERSION)-source
endef

define ESPEAK_CONFIGURE_CMDS
	# Buildroot provides portaudio V19, see ReadMe file for more details.
	cp $(@D)/src/portaudio19.h $(@D)/src/portaudio.h
endef

define ESPEAK_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) \
		AUDIO="$(ESPEAK_AUDIO_BACKEND)" \
		-C $(@D)/src all
endef

define ESPEAK_INSTALL_TARGET_CMDS
	$(MAKE) install DESTDIR="$(TARGET_DIR)" -C $(@D)/src
endef

$(eval $(generic-package))

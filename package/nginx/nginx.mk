#############################################################
#
# nginx
#
#############################################################

NGINX_VERSION = 1.6.0
NGINX_SITE = http://nginx.org/download
NGINX_SOURCE =nginx-$(NGINX_VERSION).tar.gz
NGINX_CONF_OPT = \
    --prefix=/usr \
    --sbin-path=/usr/sbin/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --http-client-body-temp-path=/tmp/nginx/client-body \
    --http-proxy-temp-path=/tmp/nginx/proxy \
    --http-fastcgi-temp-path=/tmp/nginx/fastcgi \
    --http-uwsgi-temp-path=/tmp/nginx/uwsgi \
    --http-scgi-temp-path=/tmp/nginx/scgi \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/lock/ngnix.lock \
    --user=nginx \
    --group=nginx \
    --crossbuild=cross-linux-32 \
    --with-cc="$(TARGET_CC)" \
    --with-cpp="$(TARGET_CC)" \
    --with-cc-opt="$(TARGET_CFLAGS)"

NGINX_DEPENDENCIES = libatomic_ops


ifeq ($(BR2_INET_IPV6),y)
NGINX_CONF_OPT += --with-ipv6
endif

ifeq ($(BR2_PACKAGE_NGINX_AIO),y)
NGINX_CONF_OPT += --with-file-aio
endif

ifeq ($(BR2_PACKAGE_NGINX_HTTP_CACHE),y)
NGINX_DEPENDENCIES += openssl
#NGINX_CONF_OPT += --with-openssl=$(BUILD_DIR)/openssl-$(OPENSSL_VERSION)
else
NGINX_CONF_OPT += --without-http-cache
endif

ifeq ($(BR2_PACKAGE_NGINX_HTTP_GZIP_STATIC),y)
NGINX_DEPENDENCIES += zlib
#NGINX_CONF_OPT += --with-zlib=$(BUILD_DIR)/zlib-$(ZLIB_VERSION)
NGINX_CONF_OPT += --with-http_gzip_static_module 
endif

ifeq ($(BR2_PACKAGE_NGINX_HTTP_REWRITE),y)
NGINX_CONF_ENV = PCRECONFIG=$(STAGING_DIR)/usr/bin/pcre-config
NGINX_DEPENDENCIES += pcre
#NGINX_CONF_OPT += --with-pcre=$(BUILD_DIR)/pcre-$(PCRE_VERSION)
else
NGINX_CONF_OPT += --without-pcre
NGINX_CONF_OPT += --without-http_rewrite_module
endif

ifeq ($(BR2_PACKAGE_NGINX_HTTP_SSL),y)
NGINX_DEPENDENCIES += openssl
#NGINX_CONF_OPT += --with-openssl=$(BUILD_DIR)/openssl-$(OPENSSL_VERSION)
NGINX_CONF_OPT += --with-http_ssl_module
endif

ifeq ($(BR2_PACKAGE_NGINX_HTTP_RTMP),y)
NGINX_POST_PATCH_CMDS += git clone https://github.com/arut/nginx-rtmp-module.git $(@D)/rtmp
NGINX_CONF_OPT += --add-module=$(@D)/rtmp
endif


NGINX_POST_PATCH_HOOKS = NGINX_PATCHES
define NGINX_PATCHES
    $(NGINX_POST_PATCH_CMDS)
endef

define NGINX_CONFIGURE_CMDS
    (cd $(@D);  rm -rf config.cache; \
        AR="$(TARGET_AR)" \
        CC="$(TARGET_CC)" \
        CPP="$(TARGET_CPP)" \
        RANLIB="$(TARGET_RANLIB)" \
        CFLAGS="$(TARGET_CFLAGS)" \
        CPPFLAGS="$(TARGET_CXXFLAGS)" \
        CXXFLAGS="$(TARGET_CXXFLAGS)" \
        LDFLAGS="$(TARGET_LDFLAGS)" \
        PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
        STAGING_DIR="$(STAGING_DIR)" \
        ./configure \
        $(NGINX_CONF_OPT) \
    )

endef

define NGINX_INSTALL_TARGET_CMDS

	mkdir -p $(TARGET_DIR)/etc/nginx
	mkdir -p $(TARGET_DIR)/etc/init.d
	mkdir -p $(TARGET_DIR)/var/www
	mkdir -p $(TARGET_DIR)/var/media/hls
	mkdir -p $(TARGET_DIR)/var/log/nginx
	$(INSTALL) -D -m 0755 $(@D)/objs/nginx $(TARGET_DIR)/usr/sbin/nginx
	$(INSTALL) -D -m 0644 $(@D)/conf/* $(TARGET_DIR)/etc/nginx/
	$(INSTALL) -D -m 0644 package/nginx/nginx.conf $(TARGET_DIR)/etc/nginx/
	$(INSTALL) -D -m 0755 package/nginx/S46nginx $(TARGET_DIR)/etc/init.d/

endef


define NGINX_UNINSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/usr/sbin/nginx
	rm -rf $(TARGET_DIR)/usr/lib/nginx
endef

$(eval $(autotools-package))

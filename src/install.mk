INSTALL=install -y

-include settings.conf
-include config

all: start_install

start_install:
ifeq ($(CONFIG_GIT_INSTALL), y)
	$(PKG_MANAGER) $(INSTALL) git
ifeq ($(CONFIG_GIT_COMMANDS_SETUP), y)
-include git/gitset.mk
endif
endif

ifeq ($(CONFIG_INSTALL_C_DEBuild), y)
	$(PKG_MANAGER) $(INSTALL) build-essential
endif

ifeq ($(CONFIG_INSTALL_CLIB), y)
	$(PKG_MANAGER) $(INSTALL) libncurses5-dev; \
    $(PKG_MANAGER) $(INSTALL) gawk;            \
	$(PKG_MANAGER) $(INSTALL) mtd-utils;       \
    $(PKG_MANAGER) $(INSTALL) lib32z1;         \
    $(PKG_MANAGER) $(INSTALL) lib32ncurses5;   \
    $(PKG_MANAGER) $(INSTALL) libc6:i386;      \
    $(PKG_MANAGER) $(INSTALL) zlib1g:i386
endif

ifeq ($(CONFIG_SUBL_WILL_INSTALL), y)
	$(SUBL_PACK_SET)
ifeq ($(PKG_MANAGER), apt-get)
	$(PKG_MANAGER) update
endif
	$(PKG_MANAGER) $(INSTALL) sublime-text
endif
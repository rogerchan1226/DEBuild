INSTALL = install -y

-include settings.conf
-include config

all: start_install

start_install:
ifdef GIT_INSTALL
	$(PKG_MANAGER) $(INSTALL) git
endif

ifdef INSTALL_C_DEBuild
	$(PKG_MANAGER) $(INSTALL) build-essential
endif

ifdef INSTALL_CLIB
	$(PKG_MANAGER) $(INSTALL) libncurses5-dev
    $(PKG_MANAGER) $(INSTALL) gawk
    $(PKG_MANAGER) $(INSTALL) mtd-utils
    $(PKG_MANAGER) $(INSTALL) lib32z1
    $(PKG_MANAGER) $(INSTALL) lib32ncurses5
    $(PKG_MANAGER) $(INSTALL) libc6:i386
    $(PKG_MANAGER) $(INSTALL) zlib1g:i386
endif

ifdef SUBL_WILL_INSTALL
	$(SUBL_PACK_SET)
	#if
	$(PKG_MANAGER) $(INSTALL) sublime-text
endif
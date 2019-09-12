INSTALL=install -y
GIT=git
CFG=config
GOL=--global

-include settings.conf
-include config

all: start_install

start_install:
ifeq ($(CONFIG_GIT_INSTALL), y)
	$(PKG_MANAGER) $(INSTALL) git
	$(GIT) $(CFG) $(GOL) user.name "$(NAME)"
	$(GIT) $(CFG) $(GOL) user.EMAIL "$(EMAIL)"
	$(GIT) $(CFG) $(GOL) alias.br branch
	$(GIT) $(CFG) $(GOL) alias.co checkout
	$(GIT) $(CFG) $(GOL) alias.cp cherry-pick
	$(GIT) $(CFG) $(GOL) alias.st stash
	$(GIT) $(CFG) $(GOL) alias.sub submodule	
	$(GIT) $(CFG) $(GOL) core.editor vim
	$(GIT) $(CFG) $(GOL) color.ui true
	$(GIT) $(CFG) --list	
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

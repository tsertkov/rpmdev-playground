PKG_NAME=my-world
PKG_VERSION=1-1
PKG_ARCH=x86_64

TIMESTAMP?=$(shell date +'%s')
HOME_DIR=/home/vagrant
LOGS=$(HOME_DIR)/logs

.PHONY: *
all: init build
	make install-strace; \
	make uninstall; \
	make install-debug; \
	make uninstall

init:
	$(info # Initializing rpmdev working directories)
	@rpmdev-setuptree

build:
	$(info # Building rpm package for $(PKG_NAME))
	@rpmbuild -ba $(PKG_NAME).spec

install-strace:
	$(info # Installing rpm package with strace rpm -i)
	@sudo strace -f -e trace=file \
		-o $(LOGS)/$(TIMESTAMP).rpm-strace \
		rpm -i $(HOME_DIR)/rpmbuild/RPMS/$(PKG_ARCH)/$(PKG_NAME)-$(PKG_VERSION).$(PKG_ARCH).rpm \
			> $(LOGS)/$(TIMESTAMP).rpm-stdout 2> $(LOGS)/$(TIMESTAMP).rpm-stderr

install-debug:
	$(info # Installing rpm package with rpm -i --debug)
	@sudo rpm -i --debug $(HOME_DIR)/rpmbuild/RPMS/$(PKG_ARCH)/$(PKG_NAME)-$(PKG_VERSION).$(PKG_ARCH).rpm \
		> $(LOGS)/$(TIMESTAMP).rpm-debug-stdout 2> $(LOGS)/$(TIMESTAMP).rpm-debug-stderr

uninstall:
	$(info # Uninstalling rpm package)
	@sudo rpm -e $(PKG_NAME)
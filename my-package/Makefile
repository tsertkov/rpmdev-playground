PKG_NAME=my-world
PKG_VERSION=1
PKG_RELEASE=1
PKG_ARCH=x86_64
NAME=($(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE))

HOME_DIR:=/home/vagrant
LOGS_DIR:=$(HOME_DIR)/logs
STRACE_EXCLUDE:=/usr/lib/locale/|/usr/share/locale/|/sys/fs/selinux/
TIMESTAMP?=$(shell date +'%s')
LOG_PREFIX?=$(LOGS_DIR)/$(TIMESTAMP)
PKG_FILE_NAME=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).$(PKG_ARCH).rpm
PKG_FILE=$(HOME_DIR)/rpmbuild/RPMS/$(PKG_ARCH)/$(PKG_FILE_NAME)

.PHONY: *
all: init
	@$(MAKE) --no-print-directory uninstall 2> /dev/null \
		;  $(MAKE) --no-print-directory TIMESTAMP=$(TIMESTAMP) build \
		&& $(MAKE) --no-print-directory TIMESTAMP=$(TIMESTAMP) install-strace \
		&& $(MAKE) --no-print-directory uninstall \
		&& $(MAKE) --no-print-directory TIMESTAMP=$(TIMESTAMP) install-debug \
		&& $(MAKE) --no-print-directory invoke

invoke:
	$(info $(NAME) Executing $(PKG_NAME).sh)
	@$(PKG_NAME).sh

init:
	$(info $(NAME) Initializing rpmdev working directories)
	@rpmdev-setuptree

build:
	$(info $(NAME) Building rpm package for $(PKG_NAME))
	@NAME=$(PKG_NAME) VERSION="$(PKG_VERSION)" RELEASE="$(PKG_RELEASE)" \
		envsubst \
			< package.spec.tpl \
			> $(PKG_NAME).spec
	@rpmbuild -ba $(PKG_NAME).spec \
		2> "$(LOG_PREFIX).rpm-build-stderr" \
		>  "$(LOG_PREFIX).rpm-build-stdout"

install-strace:
	$(info $(NAME) Installing rpm package with strace rpm -i)
	@sudo strace -f -e trace=file -o "$(LOG_PREFIX).rpmi-strace" \
		rpm -i "$(PKG_FILE)" \
			2> "$(LOG_PREFIX).rpmi-stderr" \
			>  "$(LOG_PREFIX).rpmi-stdout"
	@$(MAKE) STRACE_LOG_FILE="$(LOG_PREFIX).rpmi-strace" filter-strace-log

install-debug:
	$(info $(NAME) Installing rpm package with rpm -i --debug)
	@sudo rpm -i --debug "$(PKG_FILE)" \
		2> "$(LOG_PREFIX).rpmi-debug-stderr" \
		>  "$(LOG_PREFIX).rpmi-debug-stdout"

filter-strace-log: TEMP_FILE:=$(shell mktemp)
filter-strace-log:
	$(info $(NAME) Filtering strace events $(STRACE_LOG_FILE))
	@grep -Ev "$(STRACE_EXCLUDE)" "$(STRACE_LOG_FILE)" > $(TEMP_FILE)
	@mv $(TEMP_FILE) "$(STRACE_LOG_FILE)"

uninstall:
	$(info $(NAME) Uninstalling rpm package)
	@sudo rpm -e $(PKG_NAME)

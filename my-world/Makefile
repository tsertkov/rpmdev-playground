PKG_NAME=my-world
PKG_VERSION=1-1
PKG_ARCH=x86_64

HOME_DIR:=/home/vagrant
LOGS_DIR:=$(HOME_DIR)/logs
STRACE_EXCLUDE:=/usr/lib/locale/|/usr/share/locale/|/sys/fs/selinux/
TIMESTAMP?=$(shell date +'%s')
LOG_PREFIX?=$(LOGS_DIR)/$(TIMESTAMP)
PKG_FILE?=$(HOME_DIR)/rpmbuild/RPMS/$(PKG_ARCH)/$(PKG_NAME)-$(PKG_VERSION).$(PKG_ARCH).rpm

.PHONY: *
all: init
	@$(MAKE) --no-print-directory uninstall 2> /dev/null \
		;  $(MAKE) --no-print-directory TIMESTAMP=$(TIMESTAMP) build \
		&&  $(MAKE) --no-print-directory TIMESTAMP=$(TIMESTAMP) install-strace \
		&& $(MAKE) --no-print-directory uninstall \
		&& $(MAKE) --no-print-directory TIMESTAMP=$(TIMESTAMP) install-debug \
		&& $(MAKE) --no-print-directory uninstall

init:
	$(info :: Initializing rpmdev working directories)
	@rpmdev-setuptree

build:
	$(info :: Building rpm package for $(PKG_NAME))
	@rpmbuild -ba $(PKG_NAME).spec \
		> "$(LOG_PREFIX).rpm-build-stdout" \
		2> "$(LOG_PREFIX).rpm-build-stderr"

install-strace:
	$(info :: Installing rpm package with strace rpm -i)
	@sudo strace -f -e trace=file -o "$(LOG_PREFIX).rpmi-strace" \
		rpm -i "$(PKG_FILE)" \
			> "$(LOG_PREFIX).rpmi-stdout" \
			2> "$(LOG_PREFIX).rpmi-stderr"
	@$(MAKE) STRACE_LOG_FILE="$(LOG_PREFIX).rpmi-strace" filter-strace-log

install-debug:
	$(info :: Installing rpm package with rpm -i --debug)
	@sudo rpm -i --debug "$(PKG_FILE)" \
		> "$(LOG_PREFIX).rpmi-debug-stdout" \
		2> "$(LOG_PREFIX).rpmi-debug-stderr"

filter-strace-log: TEMP_FILE:=$(shell mktemp)
filter-strace-log:
	$(info :: Filtering strace events $(STRACE_LOG_FILE))
	@grep -Ev "$(STRACE_EXCLUDE)" "$(STRACE_LOG_FILE)" > $(TEMP_FILE)
	@mv $(TEMP_FILE) "$(STRACE_LOG_FILE)"

uninstall:
	$(info :: Uninstalling rpm package)
	@sudo rpm -e $(PKG_NAME)

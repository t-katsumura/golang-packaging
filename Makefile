
# Envs that can be overwritten.
PKG_VERSION ?= 0.0.0
PKG_ITERATION ?= 1
OUT_DIR ?= $(CURDIR)/output/

# Default settings.
PKG_TYPE ?= rpm
PKG_ARCH ?= x86_64
BIN_FILE ?= $(CURDIR)/hello

# Common command lines.
CMD_COMMON := fpm
CMD_COMMON += --verbose
CMD_COMMON += --force
CMD_COMMON += --input-type dir
CMD_COMMON += --name hello
CMD_COMMON += --version $(PKG_VERSION)
CMD_COMMON += --iteration $(PKG_ITERATION)
CMD_COMMON += --license "Apache 2.0"
CMD_COMMON += --vendor "HELLO WORLD"
CMD_COMMON += --url "https://github.com/"
CMD_COMMON += --maintainer "HELLO WORLD Community"
CMD_COMMON += --description "This is the hello world package."
CMD_COMMON += --architecture $(PKG_ARCH)
CMD_COMMON += --output-type $(PKG_TYPE)
CMD_COMMON += --before-install $(PKG_TYPE)/preinst
CMD_COMMON += --after-install $(PKG_TYPE)/postinst
CMD_COMMON += --before-remove $(PKG_TYPE)/prerm
CMD_COMMON += --after-remove $(PKG_TYPE)/postrm
CMD_COMMON += --package $(OUT_DIR)hello-$(PKG_VERSION)-$(PKG_ITERATION).$(PKG_ARCH).$(PKG_TYPE) \

.PHONY: fpm-rpm
fpm-rpm:
	mkdir -p $(OUT_DIR)
	$(CMD_COMMON) \
	--rpm-summary "HELLO WORLD Server." \
	--rpm-os linux \
	--rpm-digest sha256 \
	--rpm-rpmbuild-define "_build_id_links none" \
	--config-files /etc/hello/hello.conf \
	--config-files /etc/sysconfig/hello.env \
		$(BIN_FILE)=/usr/bin/hello \
		$(PKG_TYPE)/hello.conf=/etc/hello/hello.conf \
		$(PKG_TYPE)/hello.env=/etc/sysconfig/hello.env \
		$(PKG_TYPE)/hello.service=/usr/lib/systemd/system/hello.service

.PHONY: fpm-deb
fpm-deb:
	mkdir -p $(OUT_DIR)
	$(CMD_COMMON) \
	--config-files /etc/hello/hello.conf \
	--config-files /etc/default/hello.env \
		$(BIN_FILE)=/usr/bin/hello \
		$(PKG_TYPE)/hello.conf=/etc/hello/hello.conf \
		$(PKG_TYPE)/hello.env=/etc/default/hello.env \
		$(PKG_TYPE)/hello.service=/usr/lib/systemd/system/hello.service

.PHONY: fpm-apk
fpm-apk:
	mkdir -p $(OUT_DIR)
	$(CMD_COMMON) \
	--config-files /etc/hello/hello.conf \
	--config-files /etc/default/hello.env \
		$(BIN_FILE)=/usr/bin/hello \
		$(PKG_TYPE)/hello.conf=/etc/hello/hello.conf \
		$(PKG_TYPE)/hello.env=/etc/default/hello.env

.PHONY: all
all: rpm deb apk

.PHONY: rpm
rpm:
	PKG_TYPE=rpm PKG_ARCH=i386    BIN_FILE=./hello-linux-386/hello-linux-386         $(MAKE) fpm-rpm
	PKG_TYPE=rpm PKG_ARCH=x86_64  BIN_FILE=./hello-linux-amd64/hello-linux-amd64     $(MAKE) fpm-rpm
	PKG_TYPE=rpm PKG_ARCH=armv7   BIN_FILE=./hello-linux-arm/hello-linux-arm         $(MAKE) fpm-rpm
	PKG_TYPE=rpm PKG_ARCH=aarch64 BIN_FILE=./hello-linux-arm64/hello-linux-arm64     $(MAKE) fpm-rpm
	PKG_TYPE=rpm PKG_ARCH=ppc64le BIN_FILE=./hello-linux-ppc64le/hello-linux-ppc64le $(MAKE) fpm-rpm
	PKG_TYPE=rpm PKG_ARCH=riscv64 BIN_FILE=./hello-linux-riscv64/hello-linux-riscv64 $(MAKE) fpm-rpm
	PKG_TYPE=rpm PKG_ARCH=s390x   BIN_FILE=./hello-linux-s390x/hello-linux-s390x     $(MAKE) fpm-rpm

.PHONY: deb
deb:
	PKG_TYPE=deb PKG_ARCH=i386    BIN_FILE=./hello-linux-386/hello-linux-386         $(MAKE) fpm-deb
	PKG_TYPE=deb PKG_ARCH=amd64   BIN_FILE=./hello-linux-amd64/hello-linux-amd64     $(MAKE) fpm-deb
	PKG_TYPE=deb PKG_ARCH=armhf   BIN_FILE=./hello-linux-arm/hello-linux-arm         $(MAKE) fpm-deb
	PKG_TYPE=deb PKG_ARCH=arm64   BIN_FILE=./hello-linux-arm64/hello-linux-arm64     $(MAKE) fpm-deb
	PKG_TYPE=deb PKG_ARCH=ppc64el BIN_FILE=./hello-linux-ppc64le/hello-linux-ppc64le $(MAKE) fpm-deb
	PKG_TYPE=deb PKG_ARCH=riscv64 BIN_FILE=./hello-linux-riscv64/hello-linux-riscv64 $(MAKE) fpm-deb
	PKG_TYPE=deb PKG_ARCH=s390x   BIN_FILE=./hello-linux-s390x/hello-linux-s390x     $(MAKE) fpm-deb

.PHONY: apk
apk:
	PKG_TYPE=apk PKG_ARCH=i386    BIN_FILE=./hello-linux-386/hello-linux-386         $(MAKE) fpm-apk
	PKG_TYPE=apk PKG_ARCH=x86_64  BIN_FILE=./hello-linux-amd64/hello-linux-amd64     $(MAKE) fpm-apk
	PKG_TYPE=apk PKG_ARCH=armv7   BIN_FILE=./hello-linux-arm/hello-linux-arm         $(MAKE) fpm-apk
	PKG_TYPE=apk PKG_ARCH=aarch64 BIN_FILE=./hello-linux-arm64/hello-linux-arm64     $(MAKE) fpm-apk
	PKG_TYPE=apk PKG_ARCH=ppc6le  BIN_FILE=./hello-linux-ppc64le/hello-linux-ppc64le $(MAKE) fpm-apk
	PKG_TYPE=apk PKG_ARCH=riscv64 BIN_FILE=./hello-linux-riscv64/hello-linux-riscv64 $(MAKE) fpm-apk
	PKG_TYPE=apk PKG_ARCH=s390x   BIN_FILE=./hello-linux-s390x/hello-linux-s390x     $(MAKE) fpm-apk

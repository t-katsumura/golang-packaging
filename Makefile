# RPM example commands
# -----
# yum update -y && yum install -y make rpm-build rubygems
# gem install fpm
# make fpm-rpm

# DEB example commands
# -----
# apt update && apt install -y make ruby build-essential
# gem install fpm
# make fpm-deb

# APK example commands
# -----
# apk update && apk add make rpm ruby
# gem install fpm
# make fpm-apk

PKG_VERSION ?= 0.0.0
PKG_ITERATION ?= 1
OUT_DIR ?= $(CURDIR)/output/

PKG_ARCH ?= x86_64
BIN_FILE ?= $(CURDIR)/hello

CMD_COMMON := fpm
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
CMD_COMMON += --before-install preinst
CMD_COMMON += --after-install postinst
CMD_COMMON += --before-remove prerm
CMD_COMMON += --after-remove postrm

.PHONY: fpm-rpm
fpm-rpm:
	mkdir -p $(OUT_DIR)
	cd ./rpm/ && $(CMD_COMMON) \
	--output-type rpm \
	--architecture $(PKG_ARCH) \
	--package $(OUT_DIR)hello-$(PKG_VERSION)-$(PKG_ITERATION).$(PKG_ARCH).rpm \
	--rpm-summary "HELLO WORLD Server." \
	--rpm-os linux \
	--rpm-digest sha256 \
	--rpm-rpmbuild-define "_build_id_links none" \
	--config-files /etc/hello/hello.conf \
	--config-files /etc/sysconfig/hello.env \
		$(BIN_FILE)=/usr/bin/hello \
		hello.conf=/etc/hello/hello.conf \
		hello.env=/etc/sysconfig/hello.env \
		hello.service=/usr/lib/systemd/system/hello.service

.PHONY: fpm-deb
fpm-deb:
	mkdir -p $(OUT_DIR)
	cd ./rpm/ && $(CMD_COMMON) \
	--output-type deb \
	--architecture $(PKG_ARCH) \
	--package $(OUT_DIR)hello-$(PKG_VERSION)-$(PKG_ITERATION).$(PKG_ARCH).deb \
	--config-files /etc/hello/hello.conf \
	--config-files /etc/default/hello.env \
		$(BIN_FILE)=/usr/bin/hello \
		hello.conf=/etc/hello/hello.conf \
		hello.env=/etc/default/hello.env \
		hello.service=/usr/lib/systemd/system/hello.service

.PHONY: fpm-apk
fpm-apk:
	mkdir -p $(OUT_DIR)
	cd ./apk/ && $(CMD_COMMON) \
	--output-type apk \
	--architecture $(PKG_ARCH) \
	--package $(OUT_DIR)hello-$(PKG_VERSION)-$(PKG_ITERATION).$(PKG_ARCH).apk \
	--config-files /etc/hello/hello.conf \
	--config-files /etc/default/hello.env \
		$(BIN_FILE)=/usr/bin/hello \
		hello.conf=/etc/hello/hello.conf \
		hello.env=/etc/default/hello.env

.PHONY: all
all: rpm deb

.PHONY: rpm
rpm:
	$(ENV_RPM) PKG_ARCH=i386    BIN_FILE=./hello-linux-386/hello-linux-386         $(MAKE) fpm-rpm
	$(ENV_RPM) PKG_ARCH=x86_64  BIN_FILE=./hello-linux-amd64/hello-linux-amd64     $(MAKE) fpm-rpm
	$(ENV_RPM) PKG_ARCH=armv7   BIN_FILE=./hello-linux-arm/hello-linux-arm         $(MAKE) fpm-rpm
	$(ENV_RPM) PKG_ARCH=aarch64 BIN_FILE=./hello-linux-arm64/hello-linux-arm64     $(MAKE) fpm-rpm
	$(ENV_RPM) PKG_ARCH=ppc64le BIN_FILE=./hello-linux-ppc64le/hello-linux-ppc64le $(MAKE) fpm-rpm
	$(ENV_RPM) PKG_ARCH=riscv64 BIN_FILE=./hello-linux-riscv64/hello-linux-riscv64 $(MAKE) fpm-rpm
	$(ENV_RPM) PKG_ARCH=s390x   BIN_FILE=./hello-linux-s390x/hello-linux-s390x     $(MAKE) fpm-rpm

.PHONY: deb
deb:
	$(ENV_DEB) PKG_ARCH=i386    BIN_FILE=./hello-linux-386/hello-linux-386         $(MAKE) fpm-deb
	$(ENV_DEB) PKG_ARCH=amd64   BIN_FILE=./hello-linux-amd64/hello-linux-amd64     $(MAKE) fpm-deb
	$(ENV_DEB) PKG_ARCH=armhf   BIN_FILE=./hello-linux-arm/hello-linux-arm         $(MAKE) fpm-deb
	$(ENV_DEB) PKG_ARCH=arm64   BIN_FILE=./hello-linux-arm64/hello-linux-arm64     $(MAKE) fpm-deb
	$(ENV_DEB) PKG_ARCH=ppc64el BIN_FILE=./hello-linux-ppc64le/hello-linux-ppc64le $(MAKE) fpm-deb
	$(ENV_DEB) PKG_ARCH=riscv64 BIN_FILE=./hello-linux-riscv64/hello-linux-riscv64 $(MAKE) fpm-deb
	$(ENV_DEB) PKG_ARCH=s390x   BIN_FILE=./hello-linux-s390x/hello-linux-s390x     $(MAKE) fpm-deb

.PHONY: apk
apk:
	$(ENV_DEB) PKG_ARCH=i386    BIN_FILE=./hello-linux-386/hello-linux-386         $(MAKE) fpm-apk
	$(ENV_DEB) PKG_ARCH=x86_64  BIN_FILE=./hello-linux-amd64/hello-linux-amd64     $(MAKE) fpm-apk
	$(ENV_DEB) PKG_ARCH=armv7   BIN_FILE=./hello-linux-arm/hello-linux-arm         $(MAKE) fpm-apk
	$(ENV_DEB) PKG_ARCH=aarch64 BIN_FILE=./hello-linux-arm64/hello-linux-arm64     $(MAKE) fpm-apk
	$(ENV_DEB) PKG_ARCH=ppc6le  BIN_FILE=./hello-linux-ppc64le/hello-linux-ppc64le $(MAKE) fpm-apk
	$(ENV_DEB) PKG_ARCH=riscv64 BIN_FILE=./hello-linux-riscv64/hello-linux-riscv64 $(MAKE) fpm-apk
	$(ENV_DEB) PKG_ARCH=s390x   BIN_FILE=./hello-linux-s390x/hello-linux-s390x     $(MAKE) fpm-apk

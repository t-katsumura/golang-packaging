# yum setup
# -----
# yum update && yum install -y make
# yum install -y rpm-build rubygems
# gem install fpm

# apt setup
# -----
# apt update && apt install -y make
# apt install -y ruby build-essential
# gem install fpm

PKG_TYPE ?= rpm
PKG_VERSION ?= 1.0.0
PKG_ITERATION ?= 1
PKG_ARCH ?= x86_64
ENV_FILE ?= /etc/sysconfig/hello

ASSET_DIR ?= ./$(PKG_TYPE)/
BIN_FILE ?= hello

.PHONY: build
build:
	mkdir -p ./output/
	fpm \
	--force \
	--input-type dir \
	--output-type $(PKG_TYPE) \
	--package ./output/hello-$(PKG_VERSION)-$(PKG_ITERATION).$(PKG_ARCH).$(PKG_TYPE) \
	--name hello \
	--version $(PKG_VERSION) \
	--iteration $(PKG_ITERATION) \
	--license "Apache 2.0" \
	--vendor "HELLO WORLD" \
	--url "https://github.com/" \
	--maintainer "HELLO WORLD Community" \
	--rpm-summary "HELLO WORLD Server." \
	--description "This is the hello world package." \
	--rpm-os linux \
	--architecture $(PKG_ARCH) \
	--rpm-rpmbuild-define "_build_id_links none" \
	--rpm-digest sha256 \
	--before-install $(ASSET_DIR)preinst \
	--after-install $(ASSET_DIR)postinst \
	--before-remove $(ASSET_DIR)prerm \
	--after-remove $(ASSET_DIR)postrm \
	--config-files /etc/hello/hello.conf \
	--config-files $(ENV_FILE) \
		$(BIN_FILE)=/usr/bin/hello \
		$(ASSET_DIR)hello.conf=/etc/hello/hello.conf \
		$(ASSET_DIR)hello.env=$(ENV_FILE) \
		$(ASSET_DIR)hello.service=/usr/lib/systemd/system/hello.service

ENV_RPM := PKG_TYPE=rpm ASSET_DIR=./rpm/ ENV_FILE=/etc/sysconfig/hello
ENV_DEB := PKG_TYPE=deb ASSET_DIR=./deb/ ENV_FILE=/etc/default/hello

.PHONY: all
all: rpm deb

.PHONY: rpm
rpm:
	$(ENV_RPM) PKG_ARCH=i386    BIN_FILE=./hello-linux-386/hello-linux-386         $(MAKE) build
	$(ENV_RPM) PKG_ARCH=amd64   BIN_FILE=./hello-linux-amd64/hello-linux-amd64     $(MAKE) build
	$(ENV_RPM) PKG_ARCH=arm     BIN_FILE=./hello-linux-arm/hello-linux-arm         $(MAKE) build
	$(ENV_RPM) PKG_ARCH=arm64   BIN_FILE=./hello-linux-arm64/hello-linux-arm64     $(MAKE) build
	$(ENV_RPM) PKG_ARCH=ppc64le BIN_FILE=./hello-linux-ppc64le/hello-linux-ppc64le $(MAKE) build
	$(ENV_RPM) PKG_ARCH=riscv64 BIN_FILE=./hello-linux-riscv64/hello-linux-riscv64 $(MAKE) build
	$(ENV_RPM) PKG_ARCH=s390x   BIN_FILE=./hello-linux-s390x/hello-linux-s390x     $(MAKE) build

.PHONY: deb
deb:
	$(ENV_DEB) PKG_ARCH=i386    BIN_FILE=./hello-linux-386/hello-linux-386         $(MAKE) build
	$(ENV_DEB) PKG_ARCH=amd64   BIN_FILE=./hello-linux-amd64/hello-linux-amd64     $(MAKE) build
	$(ENV_DEB) PKG_ARCH=arm     BIN_FILE=./hello-linux-arm/hello-linux-arm         $(MAKE) build
	$(ENV_DEB) PKG_ARCH=arm64   BIN_FILE=./hello-linux-arm64/hello-linux-arm64     $(MAKE) build
	$(ENV_DEB) PKG_ARCH=ppc64el BIN_FILE=./hello-linux-ppc64le/hello-linux-ppc64le $(MAKE) build
	$(ENV_DEB) PKG_ARCH=riscv64 BIN_FILE=./hello-linux-riscv64/hello-linux-riscv64 $(MAKE) build
	$(ENV_DEB) PKG_ARCH=s390x   BIN_FILE=./hello-linux-s390x/hello-linux-s390x     $(MAKE) build

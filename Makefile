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

# OS:
# ARCH: i386,amd64,arm,arm64,ppc64le(rhel),ppc64el(debian),riscv64,s390x
# ITERATION: a1,a2,... b1,b2,... r1,r2,...

PKG_TYPE ?= rpm
PKG_VERSION ?= 1.0.0
PKG_ITERATION ?= 1
PKG_OS ?= linux
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
	--vendor "AILERON Gateway" \
	--url "https://github.com/aileron-gateway/" \
	--maintainer "AILERON Gateway Community" \
	--rpm-summary "AILERON Gateway. Enterprise-grade API  gateway." \
	--description "This package contains the intdash Auth Service." \
	--rpm-os $(PKG_OS) \
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
	$(ENV_RPM) PKG_ARCH=i386 BIN_FILE=hello-linux-386 $(MAKE) build
	$(ENV_RPM) PKG_ARCH=amd64 BIN_FILE=hello-linux-amd64 $(MAKE) build
	$(ENV_RPM) PKG_ARCH=arm BIN_FILE=hello-linux-arm $(MAKE) build
	$(ENV_RPM) PKG_ARCH=arm64 BIN_FILE=hello-linux-arm64 $(MAKE) build
	$(ENV_RPM) PKG_ARCH=ppc64le BIN_FILE=hello-linux-ppc64le $(MAKE) build
	$(ENV_RPM) PKG_ARCH=riscv64 BIN_FILE=hello-linux-riscv64 $(MAKE) build
	$(ENV_RPM) PKG_ARCH=s390x BIN_FILE=hello-linux-s390x $(MAKE) build

.PHONY: deb
deb:
	$(ENV_DEB) PKG_ARCH=i386 BIN_FILE=hello-linux-386 $(MAKE) build
	$(ENV_DEB) PKG_ARCH=amd64 BIN_FILE=hello-linux-amd64 $(MAKE) build
	$(ENV_DEB) PKG_ARCH=arm BIN_FILE=hello-linux-arm $(MAKE) build
	$(ENV_DEB) PKG_ARCH=arm64 BIN_FILE=hello-linux-arm64 $(MAKE) build
	$(ENV_DEB) PKG_ARCH=ppc64el BIN_FILE=hello-linux-ppc64le $(MAKE) build
	$(ENV_DEB) PKG_ARCH=riscv64 BIN_FILE=hello-linux-riscv64 $(MAKE) build
	$(ENV_DEB) PKG_ARCH=s390x BIN_FILE=hello-linux-s390x $(MAKE) build

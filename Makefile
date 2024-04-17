# OS:
# ARCH: i386,amd64,arm,arm64,ppc64le(rhel),ppc64el(debian),riscv64,s390x
# ITERATION: a1,a2,... b1,b2,... r1,r2,...

PKG_TYPE ?= rpm
PKG_VERSION ?= 1.0.0
PKG_ITERATION ?= 1
PKG_OS ?= linux
s390x ?= x86_64
ENV_FILE ?= /etc/sysconfig/hello
BIN_FILE ?= hello

.PHONY: build
build:
	fpm \
	--force \
	--input-type dir \
	--output-type $(PKG_TYPE) \
	--package hello-$(PKG_VERSION)-$(PKG_ITERATION).$(PKG_ARCH).$(PKG_TYPE) \
	--chdir ./$(PKG_TYPE) \
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
	--before-install ./$(PKG_TYPE)/preinst \
	--after-install ./$(PKG_TYPE)/postinst \
	--before-remove ./$(PKG_TYPE)/prerm \
	--after-remove ./$(PKG_TYPE)/postrm \
	--config-files /etc/hello/hello.conf \
	--config-files $(ENV_FILE) \
		$(BIN_FILE)=/usr/bin/hello \
		hello.conf=/etc/hello/hello.conf \
		hello.env=$(ENV_FILE) \
		hello.service=/usr/lib/systemd/system/hello.service

.PHONY: yum-setup
yum-setup:
	yum -y update
	yum install -y ruby-devel gcc make rpm-build rubygems
	gem install fpm

.PHONY: apt-setup
apt-setup:
	apt-get update
	apt-get install -y ruby ruby-dev rubygems build-essential
	gem install fpm

ENV_RPM := PKG_TYPE=rpm ENV_FILE=/etc/sysconfig/hello
ENV_DEB := PKG_TYPE=deb ENV_FILE=/etc/default/hello

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

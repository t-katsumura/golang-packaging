# golang-packaging

This repository is an example of creating `.rpm`, `.deb` and `apk` packages for Golang applications.

## How to use

### Setup environments

**Install Golang**

See <https://go.dev/doc/install>

**Setup fpm with yum**

```sh
yum update -y && yum install -y make rpm-build rubygems
gem install fpm
```

**Setup fpm with apt**

```sh
apt update && apt install -y make ruby build-essential
gem install fpm
```

**Setup fpm with apk**

```sh
apk update && apk add make rpm ruby tar
gem install fpm
```

### Build binary

```sh
CGO_ENABLED=0 go build -ldflags="-w -s" ./hello.go
```

### Create packages

Default version and arch are defined in [./Makefile](./Makefile).
Overwrite them if necessary.

Packages are output in `./packages/` directory by default.

**.rpm using fpm**

```sh
make fpm-rpm
```

**.deb using fpm**

```sh
make fpm-deb
```

**.apk using fpm**

```sh
make fpm-apk
```

## Install and Remove

**apt**

```sh
# Install
apt install ./hello-0.0.0-1.x86_64.deb
# Remove
apt remove --purge hello
```

**rpm**

```sh
# Install
rpm --nodeps -ivh ./hello-0.0.0-1.x86_64.rpm
# Remove
rpm -e hello-0.0.0-1.x86_64
```

**yum**

```sh
# Install
yum install ./hello-0.0.0-1.x86_64.rpm
# Remove
yum remove -y hello
```

**apk**

```sh
# Install
apk add --allow-untrusted hello-0.0.0-1.x86_64.apk
# Remove
apk del hello
```

## References

- <https://fpm.readthedocs.io/en/v1.15.1/>
- <https://wiki.alpinelinux.org/wiki/Creating_an_Alpine_package>
- <https://nfpm.goreleaser.com/>
- <https://github.com/grafana/alloy/blob/main/tools/make/packaging.mk>
